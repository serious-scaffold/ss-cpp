#include <gtest/gtest.h>
#include "absl/log/globals.h"
#include "absl/log/initialize.h"
#include "absl/log/log.h"
#include "jvm_util.hpp"

TEST(jvm, JvmInitFail) {
    ASSERT_EXIT(jvm::Jvm::instance(),
                ::testing::ExitedWithCode(255), // will exit -1
                ".*"                            // match anything output
    );
}

TEST(jvm, JvmCallJava) {
    const jint jvm_version = JNI_VERSION_19;
    std::vector<JavaVMOption> vm_options{
        JavaVMOption{
            .optionString = (char*)"-Djava.class.path=test_jar.jar",
            .extraInfo = nullptr,
        },
    };
    JavaVMInitArgs vm_args;
    vm_args.version = jvm_version;       // minimum Java version
    vm_args.options = vm_options.data(); // JVM invocation options
    vm_args.nOptions = vm_options.size();
    vm_args.ignoreUnrecognized = 1; // invalid options make the JVM init fail

    jvm::Jvm::instance(vm_args).call([](JNIEnv* env) {
        // Construct a String
        jstring jstr = env->NewStringUTF("Hello World");

        // Get the method that you want to call
        jmethodID to_lower =
            env->GetMethodID(env->FindClass("java/lang/String"), "toLowerCase", "()Ljava/lang/String;");

        // Call the method on the object
        jobject result = env->CallObjectMethod(jstr, to_lower);

        // Get a C-style string
        const char* str = env->GetStringUTFChars((jstring)result, NULL);

        LOG(INFO) << str;

        // Clean up
        env->ReleaseStringUTFChars(jstr, str);
    });

    jvm::Jvm::instance().call([](JNIEnv* env) {
        jclass j_my_test = env->FindClass("MyTest");
        jmethodID j_mymain = env->GetStaticMethodID(j_my_test, "mymain", "()V");
        if (j_my_test && j_mymain)
            env->CallStaticVoidMethod(j_my_test, j_mymain);
    });
}
