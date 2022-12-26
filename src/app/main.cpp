/*-------------------------------------------------------------------------------------------------------------
 * Copyright (c) Microsoft Corporation. All rights reserved.
 * Licensed under the MIT License. See https://go.microsoft.com/fwlink/?linkid=2090316 for license information.
 *-------------------------------------------------------------------------------------------------------------*/

#include <iostream>
#include "api.hpp"
#include "impl/impl.hpp"

int main() {
    using namespace std;
    cout << "Hello, Remote World!"
         << "\n"
         << api::info::version_api();
    return 0;
}