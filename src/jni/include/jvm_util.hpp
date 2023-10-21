#pragma once

#include <cstdlib>
#include <functional>
#include <vector>
#include "absl/log/log.h"
#include "jni.h"
#include "jni_md.h"

// Disable leak detection from sanitizer, see
// https://stackoverflow.com/questions/51060801/how-to-suppress-leaksanitizer-report-when-running-under-fsanitize-address
#ifdef __cplusplus
extern "C" {
    const char *__asan_default_options() {
        return "detect_leaks=0";
    }
}
#endif

namespace jvm {
class Jvm {
public:
    JNIEnv *jvm_env() { return env; }

    static Jvm &instance(const JavaVMInitArgs &vm_args = {}) {
        static auto singleton = Jvm(vm_args);
        return singleton;
    }

    void call(std::function<void(JNIEnv *)> callback) { return callback(env); }

private:
    Jvm(const JavaVMInitArgs &vm_args = {}) {
        jint res = JNI_CreateJavaVM(&vm, (void **)&env, (void *)&vm_args);
        if (res < 0) {
            LOG(INFO) << "Init JVM failed";
            exit(-1);
        }
        //=============== Display JVM version =======================================
        jint ver = env->GetVersion();
        LOG(INFO) << "Loaded JVM Version " << ((ver >> 16) & 0x0f) << "." << (ver & 0x0f);
    }

    ~Jvm() { // Shutdown the VM. But it never calls this
        if (vm) {
            vm->DestroyJavaVM();
        }
        vm = nullptr;
    }

    Jvm(const Jvm &) = delete;
    Jvm &operator=(const Jvm &) = delete;
    JavaVM *vm{nullptr};
    JNIEnv *env{nullptr};
};

} // namespace jvm
