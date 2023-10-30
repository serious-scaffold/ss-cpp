#include "absl/log/globals.h"
#include "absl/log/initialize.h"
#include "absl/log/log.h"
#include "git.h"
#include "helpers.hpp"

int main() {
    absl::InitializeLog();
    absl::SetStderrThreshold(absl::LogSeverity::kInfo);
    LOG(INFO) << "Get a returned value: " << executable::helpers::some_fun() << " ; Version: " << git::ProjectVersion();
    return 0;
}
