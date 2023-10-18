## 1.0.0 (2023-10-17)


### Features

* add coverage reports to sphinx docs ([dc1a994](https://github.com/msclock/cpp-scaffold/commit/dc1a9941f06a1f87b621dc89cdcbb154ab482607))
* add sphinx docs generator ([b29eabd](https://github.com/msclock/cpp-scaffold/commit/b29eabde3efd8f4d910da7e56318e4f4322f68c9))
* convert to copier template ([#3](https://github.com/msclock/cpp-scaffold/issues/3)) ([c34e6ca](https://github.com/msclock/cpp-scaffold/commit/c34e6ca3a5fc81cfd65901e103a518ab89e146cd)), closes [#2](https://github.com/msclock/cpp-scaffold/issues/2)


### Bug Fixes

* absl log initialize ([1cd782f](https://github.com/msclock/cpp-scaffold/commit/1cd782ff6a7812d657be75ca4534798cbf6de3d4))
* cdash missed submit url ([e1036ea](https://github.com/msclock/cpp-scaffold/commit/e1036ead2d6fa8917dc3c21ee7a81825e70fb588))
* correct cmake config ([23d1c38](https://github.com/msclock/cpp-scaffold/commit/23d1c38485bab06e63622340d06c8bdb49b3d6ef))
* missing debug distribution libs on windows ([fa29779](https://github.com/msclock/cpp-scaffold/commit/fa29779f694a9fa3c01658332b68d5e52a6a7ea6)), closes [#7](https://github.com/msclock/cpp-scaffold/issues/7)


### Style

* add note to CPM usage and jinja format for cmake files ([eb33962](https://github.com/msclock/cpp-scaffold/commit/eb339629e09744c8346ad42f1762b8859496fffd))
* change doxygen style from @ to \ ([c942de5](https://github.com/msclock/cpp-scaffold/commit/c942de5550cca3925f53d1a3f5f96e6427e8967d))
* cmake format ([620098e](https://github.com/msclock/cpp-scaffold/commit/620098edc34b0f7b3f2f4d5184e4fcf464f0f120))
* confrom to pre-commit ([610db4a](https://github.com/msclock/cpp-scaffold/commit/610db4af5139a821e90fef80dbc2a4393601b2cb))
* confront to precommit ([6f7799f](https://github.com/msclock/cpp-scaffold/commit/6f7799f0565236f408fcb91e53dbd7f5c4b5c2a6))
* disable cmake format block ([d1e5d67](https://github.com/msclock/cpp-scaffold/commit/d1e5d6731c8fe7fc0f84a4536c5d09b6cc869702))
* fix typo ([b7dfbf2](https://github.com/msclock/cpp-scaffold/commit/b7dfbf22a96a894e2eae56b2fc1cd613c73b1a69))
* format cmake module OSInstall ([9184142](https://github.com/msclock/cpp-scaffold/commit/9184142a05d7e7a691401693e861cb20204e13c9))


### Performance

* add header-only demo and move tests ([bf8d79e](https://github.com/msclock/cpp-scaffold/commit/bf8d79e5bc850be01dc4343051e01d66cfadf0f5))
* add header/app/api options to copier ([4df2110](https://github.com/msclock/cpp-scaffold/commit/4df21102fa74894acbbe6065ff61b8740e2179f2))
* **build:** perf memcheck with valgrind and sanitizers ([0b14142](https://github.com/msclock/cpp-scaffold/commit/0b141426cf0155b488e71c6aa4cffe407c4a2bcc))
* check vcpkg build env existence ([159d238](https://github.com/msclock/cpp-scaffold/commit/159d238071276f3df133d2c77acf5eee1806fbd6))
* cmake install exclude test things ([90b3dda](https://github.com/msclock/cpp-scaffold/commit/90b3ddaa46cb42496ff1f4fbd32062b3e5eaec18))
* cmake output about rpath ([6bb694f](https://github.com/msclock/cpp-scaffold/commit/6bb694fc34676cb8272da7d4e0cc17f6be38d012))
* consistency test output name ([c774234](https://github.com/msclock/cpp-scaffold/commit/c7742349adf16590e90ac67935585060a368e9dd))
* correct config annotation ([7658694](https://github.com/msclock/cpp-scaffold/commit/765869417533befd4cabd9e497eb7026b0fe96c0))
* dev container ([0161274](https://github.com/msclock/cpp-scaffold/commit/0161274011b0dbb99e10dd7b2101ecff90614fb7))
* improve readablity on OS dependencies resolving ([2d52c34](https://github.com/msclock/cpp-scaffold/commit/2d52c34ea19bf810f8d51138582fd6da77278003))
* make cpm/conan as a option based on copier ([ef04c79](https://github.com/msclock/cpp-scaffold/commit/ef04c79e12870edbd922fd4166805c29f798d5c9)), closes [#11](https://github.com/msclock/cpp-scaffold/issues/11)
* make the cdash as an option ([c6beddd](https://github.com/msclock/cpp-scaffold/commit/c6bedddd942468f9b99cf9b6af7d0d4c3c4e4429))
* resort cmake ([68ba031](https://github.com/msclock/cpp-scaffold/commit/68ba0319c840d426708f145a27c4ba193af58d31))
* robust sanitizer and dependentcies  config ([84dcf20](https://github.com/msclock/cpp-scaffold/commit/84dcf20f136c2b2e6a4f1a6f9893a02720e7f43e))
* runpath setup for shared libraries and executables ([70603aa](https://github.com/msclock/cpp-scaffold/commit/70603aa7039b8eb23d3f16514b4d6a6a0e79e646))
* simplify matches on sanitizer ([09291ec](https://github.com/msclock/cpp-scaffold/commit/09291ec78387a3dc9f60b5d3bd83d7c0aaf7d5f8))
* update cmake-registry baseline and related gtest conf ([ed6874e](https://github.com/msclock/cpp-scaffold/commit/ed6874e758150c59ca4d2242f80cf46173deca04))
* use cmake-registry ([9fa3fd3](https://github.com/msclock/cpp-scaffold/commit/9fa3fd3b40c7fd483aaaf9ec87f96dca5b208b0a)), closes [#4](https://github.com/msclock/cpp-scaffold/issues/4)
* use snake case for cmake config files ([e241e26](https://github.com/msclock/cpp-scaffold/commit/e241e26547b61ffe59360c45ab652cdee4e0637b))


### Chores

* add _DEBUG macro on linux when using Debug configuration. ([f47cdf7](https://github.com/msclock/cpp-scaffold/commit/f47cdf7b1f5765a02c008b44b106e0edb4d8ac1d))
* add C detection and set version 0.0.0 ([bb3c090](https://github.com/msclock/cpp-scaffold/commit/bb3c0901e5b7c8af07b3f0d3e3b7f16ed5ef9859))
* add cmake files to editorconfig ([6dd07b6](https://github.com/msclock/cpp-scaffold/commit/6dd07b6563c13deb8802ffd9c50d21f390986705))
* add editorconfig ([402c74d](https://github.com/msclock/cpp-scaffold/commit/402c74d212dfb9ef301943edd300949d504ef904))
* add extension for editorconfig and containerEnv TZ ([7b6eb2d](https://github.com/msclock/cpp-scaffold/commit/7b6eb2de351f74e4bc886ce5593df554fcbd525b))
* add sanitizer for gnu ([e59a997](https://github.com/msclock/cpp-scaffold/commit/e59a9973868187db70582b68c065c78138881866))
* adjust project layout ([f8ef81e](https://github.com/msclock/cpp-scaffold/commit/f8ef81ed96f2e8fb56b392857cf86d4893634cb5))
* bind cmake preset and more relative docs ([cf01fe9](https://github.com/msclock/cpp-scaffold/commit/cf01fe9bc1a3bead236f91c2ca5e274531497598))
* **build:**  add system deps libs when installing ([a11cc71](https://github.com/msclock/cpp-scaffold/commit/a11cc713d0e4ff6d524d428e6d2943c8dd328b7c))
* **build:** add ccache and ipo perf ([c1df983](https://github.com/msclock/cpp-scaffold/commit/c1df9838aec983429ff610fbb01da559adad6557))
* **build:** cmake build assistant tools ([952fa61](https://github.com/msclock/cpp-scaffold/commit/952fa611d003fa10ec74d2ad1cc19e167f218deb))
* **build:** cmakePresets and sanitizer not support with llvm on windows ([37197d1](https://github.com/msclock/cpp-scaffold/commit/37197d18086ff1431bc1ee6e936e3f6b097b144b))
* **build:** config for debug library generation ([af123ff](https://github.com/msclock/cpp-scaffold/commit/af123ffe5aa7008508dd7843b87a97b08a40491f))
* **build:** distinguish clangcl from clang on windows ([0264a7b](https://github.com/msclock/cpp-scaffold/commit/0264a7b262670f8100d22770459be18c9fb59680))
* **build:** perf coverage compilation ([5c2015a](https://github.com/msclock/cpp-scaffold/commit/5c2015adcd8f0f3e6bd63a88d42c7ce9b0192871))
* **build:** remove useless cmake scripts for cpack ([fbd0d67](https://github.com/msclock/cpp-scaffold/commit/fbd0d6714c3aefc57df3e46112e625d93ccc8ced))
* **build:** resort cmake sanitizer annotations ([b1e8267](https://github.com/msclock/cpp-scaffold/commit/b1e8267b986185dcc049f104b03bfd66782d3827))
* **build:** robust build system and annotations ([7525bb9](https://github.com/msclock/cpp-scaffold/commit/7525bb91141a75c874cc8c63754afd79ddebca05))
* **build:** robust cmake presets and other tools ([6aac10d](https://github.com/msclock/cpp-scaffold/commit/6aac10d171fa3d8d774a3ee638aea115567f7f35))
* **build:** 添加 VS Coverage 链接选项/PROFILE ([0e84487](https://github.com/msclock/cpp-scaffold/commit/0e8448761835878d923f6d1bc3fc2e9721a77105))
* **ci:** fix warning from job pre-commit ([81b8b90](https://github.com/msclock/cpp-scaffold/commit/81b8b901febd1f1f7cb9742f75a809300e581976))
* **cmake:** cdash and fix cmakepresets ([33d8b06](https://github.com/msclock/cpp-scaffold/commit/33d8b0641991153bc06c55741211ab0eac09d875))
* coverage configuration for gcc and clang ([96b1a28](https://github.com/msclock/cpp-scaffold/commit/96b1a28b13165cd6cd6b376f382f6ec2a4e541fe))
* **deps:** resort deps ([567857b](https://github.com/msclock/cpp-scaffold/commit/567857b376eb8ea3860f139d505004e29f8ef41d))
* dev container and more format ([892102d](https://github.com/msclock/cpp-scaffold/commit/892102d6a470b39e7567b2e88f21acdd0da48f1a))
* dev less exts ([3e7cd9c](https://github.com/msclock/cpp-scaffold/commit/3e7cd9cb001f513ef2264af769bde8c4edd8a00c))
* **dev:** change dev deps ([ad1e48b](https://github.com/msclock/cpp-scaffold/commit/ad1e48b74370e988fd4a4425956cb193b2b12633))
* devcontainer missing path ~/.local/bin ([b095985](https://github.com/msclock/cpp-scaffold/commit/b09598509002625dc419110e17f1eefd3c1e7c1c))
* **dev:** default devcontainer settings ([0493d64](https://github.com/msclock/cpp-scaffold/commit/0493d64629b185f6dc5fe4c9a9184c15d61b656d))
* **dev:** remove some useless exts ([cc68ffb](https://github.com/msclock/cpp-scaffold/commit/cc68ffbc290421df1772c7ced11c7f6704a92278))
* disable build binary on source dir ([b92ebfe](https://github.com/msclock/cpp-scaffold/commit/b92ebfe00f82ef05544b06c55a053d9040f048ed))
* disable dart warnings ([6cdd25b](https://github.com/msclock/cpp-scaffold/commit/6cdd25b22133662f7a6bcd3faaf0ec82d2010441))
* **docs:** fix docs generation ([d4a3ef8](https://github.com/msclock/cpp-scaffold/commit/d4a3ef8051b24dbdc0e761bbe49742e2b457d1ec))
* fix .cmake ext based on editorconfig ([56357ba](https://github.com/msclock/cpp-scaffold/commit/56357ba270a256827de17ca3e80fd57e79e987c1))
* gtest from gitlab is more accessible ([e37c35c](https://github.com/msclock/cpp-scaffold/commit/e37c35cfb9c45ceb4d3099562b415d7a44172491))
* improve pre-commit and add md lint fix ([bd7dfd1](https://github.com/msclock/cpp-scaffold/commit/bd7dfd10116ce14c6d20ee8a46559ee2fb0ab358))
* improve readability ([cfe1906](https://github.com/msclock/cpp-scaffold/commit/cfe19065898b0f5ba604ae7ff0c44548f0976568))
* improve readability on sphinx module ([9bcd5d7](https://github.com/msclock/cpp-scaffold/commit/9bcd5d7c69320b0c6449b1ec1f4fc88bba1ee8d8))
* more annotations about coverage ([9948907](https://github.com/msclock/cpp-scaffold/commit/9948907b68f39ed416da631aa7ae168ba600ba42))
* more dev container docs ([4132095](https://github.com/msclock/cpp-scaffold/commit/4132095057fed1dce56bcf9db5494361f110f031))
* more general config on copier.yml ([5b85fc3](https://github.com/msclock/cpp-scaffold/commit/5b85fc31cc27fb2884cdad71e3f2f4d27dd25e56))
* more generic devcontainer configuration ([be86677](https://github.com/msclock/cpp-scaffold/commit/be86677c97ed58da4480a1ae01c66041dd9b862b))
* more readable cmake presets ([b042739](https://github.com/msclock/cpp-scaffold/commit/b04273901aa77471b15367c8049c9b092fe72da1))
* more robust and more readable ([b536dbc](https://github.com/msclock/cpp-scaffold/commit/b536dbc26e246535e8bb8f8a63edc0b38a4a9a9c))
* optimize devcontainer and docs, scripts ([8aa921b](https://github.com/msclock/cpp-scaffold/commit/8aa921b07668f989f1fe4f7b5771c8749ad151ce))
* perf runpath ([d28e11f](https://github.com/msclock/cpp-scaffold/commit/d28e11fe55bb90c9c0b1d50e6dd9dc7f6f3cead1))
* **perf:** add dotnet to dev container ([d441351](https://github.com/msclock/cpp-scaffold/commit/d4413512120dde698a62b97766a9117775097a57))
* reduce requirement from manifest `vcpkg.json` ([df67e7f](https://github.com/msclock/cpp-scaffold/commit/df67e7fc4f8ea83625ef9b4c52cd64c9be16d3ed))
* remove and update useless hook ([3f8f53f](https://github.com/msclock/cpp-scaffold/commit/3f8f53f74fd512e7086803a763cabd48a375f6ff))
* remove github mirror access ([4d94319](https://github.com/msclock/cpp-scaffold/commit/4d9431948c49384918dc3f055bfa13a83b419ce2))
* remove libredwg ([fcd964c](https://github.com/msclock/cpp-scaffold/commit/fcd964c05068ab6b861e983538b24dc04390f0ad))
* remove reconfigure to sphinx conf.py ([3001996](https://github.com/msclock/cpp-scaffold/commit/300199686340762812f36a89f2f2f0e2e4f7bc51))
* remove redundant feature ([30b963c](https://github.com/msclock/cpp-scaffold/commit/30b963c5bd851e94161cc8306ced95641120dc40))
* remove redundant link from gcov with llvm coverage tools ([46d4b99](https://github.com/msclock/cpp-scaffold/commit/46d4b99baf6d1103ff4eda7b79427b8a20fdaef3))
* rm .copier-answers.yml ([dd44a88](https://github.com/msclock/cpp-scaffold/commit/dd44a886704b322edd95e6cae23ae31e1a1d36b5))
* schudle update pre-commit on 0 0 1 * * ([deb923c](https://github.com/msclock/cpp-scaffold/commit/deb923c926522922c9fec3a6392bbdd2ef09fd5f))
* spell check failed ([2f32f61](https://github.com/msclock/cpp-scaffold/commit/2f32f611e0c28c1679e0e34c770a7e7c1402fa1a))
* update devcontainer and pre-commit ([b8e6c1a](https://github.com/msclock/cpp-scaffold/commit/b8e6c1a73145ffc3a523888367dfd43908b0e2bf))
* update devcontainer configuration ([ebb3943](https://github.com/msclock/cpp-scaffold/commit/ebb39438a72f8477edf4eba27a9b81155a098b3c))
* update git config ([f6376a4](https://github.com/msclock/cpp-scaffold/commit/f6376a463dcf994f403a03750510c1a808addbf7))
* update gtest 3d787f5a0d5 ([b3a1868](https://github.com/msclock/cpp-scaffold/commit/b3a1868d5f6ddfc52d2937a7902b76bdb00eeca4))
* update LICENSE ([2cea54d](https://github.com/msclock/cpp-scaffold/commit/2cea54dacc649d1930db29b58096a1fdcc2a6f3b))
* update vcpkg configuration baseline ([2629751](https://github.com/msclock/cpp-scaffold/commit/26297510a26fd64d412a7ac511e3fa1be27f37a0))
* update yaml lint for pre-commit ([c37375e](https://github.com/msclock/cpp-scaffold/commit/c37375ec403ebc25a6d774bcb48e6ef9944c89f3))
* using GITHUB_TOKEN ([cde37b5](https://github.com/msclock/cpp-scaffold/commit/cde37b5d096b91b4b8a28fab64d98f2a0eede9d3))
* using yaml instead of jsonc ([e3e45cd](https://github.com/msclock/cpp-scaffold/commit/e3e45cd18f55411811746e4c5881c411d202ea8c))
* 优化dev container ([1759216](https://github.com/msclock/cpp-scaffold/commit/175921664231e431a765851dd07d048aa1f1d7b1))
* 优化runpath ([fa504b5](https://github.com/msclock/cpp-scaffold/commit/fa504b5036bbf12aec7ba8d2ad8d6c3abe5ce0f7))
* 剔除 OpenMP 依赖 ([a9778e0](https://github.com/msclock/cpp-scaffold/commit/a9778e079c47097bd5255a9ad510d351d2e059a9))


### Build

* dependency library installation ([9bc21e8](https://github.com/msclock/cpp-scaffold/commit/9bc21e845af1770c7f25823c48123543b3466a2a))
* ipo support ([938eb17](https://github.com/msclock/cpp-scaffold/commit/938eb17280bd27ac7690b76e74b224bdc80f9f6b))
* **lint:** lint integration ([0e648b1](https://github.com/msclock/cpp-scaffold/commit/0e648b11b647912cefe1d9835c9e0d80dc82155a))
* **perf:** docs generation ([679377f](https://github.com/msclock/cpp-scaffold/commit/679377fbbad72d75f9b139d6e364959c5dc99b5d))
* **refactor:** refact from export api to app api ([5a0cdb6](https://github.com/msclock/cpp-scaffold/commit/5a0cdb6eb00d4c7c1152b20a63d38593b6b6c337))
* update vcpkg baseline and related modules ([b8b084d](https://github.com/msclock/cpp-scaffold/commit/b8b084d447784ecb90aa7d38ab6c746367339de0))
* 构建环境 ([4bebe8a](https://github.com/msclock/cpp-scaffold/commit/4bebe8abef36f71a89de941c01b9e296fee26935))


### CI

* add release flow ([38aec3b](https://github.com/msclock/cpp-scaffold/commit/38aec3b31e2e408be8ecf1d86b9b677f883ed7b0))
* auto fixes from pre-commit ([25a39e6](https://github.com/msclock/cpp-scaffold/commit/25a39e67187acd912cfe7fad3bb16adfebb93dc2))
* auto fixes from pre-commit ([7114474](https://github.com/msclock/cpp-scaffold/commit/7114474020b048011eb1424fffaf37df78dc135e))
* auto fixes from pre-commit ([8505d4f](https://github.com/msclock/cpp-scaffold/commit/8505d4ffe17ffeb04880138a65e204429a6aadf9))
* auto fixes from pre-commit ([6821b0b](https://github.com/msclock/cpp-scaffold/commit/6821b0bc8593d598ef8a6948bbe17caa196baf36))
* auto fixes from pre-commit ([e067c9c](https://github.com/msclock/cpp-scaffold/commit/e067c9c5d333d3ae0a2925b4d8609b8552569cb9))
* auto fixes from pre-commit ([4c2bba8](https://github.com/msclock/cpp-scaffold/commit/4c2bba8a10a0851b77f966da4173ddce90217e44))
* provide main ci and organise ci rules ([f9167fc](https://github.com/msclock/cpp-scaffold/commit/f9167fc8d6efa862be0a53b47ab625e479bd10d1))
* update pre-commit hooks ([82fa0bb](https://github.com/msclock/cpp-scaffold/commit/82fa0bb5bb65bfcffd85dfa3b3cccaed8d4b71b1))
* update pre-commit hooks ([b6eeab8](https://github.com/msclock/cpp-scaffold/commit/b6eeab8bcaf9209372b6a52b357770e1a6d5b51e))


### Docs

* **readme:** more info on readme ([7718e76](https://github.com/msclock/cpp-scaffold/commit/7718e76eb9dc7d2b24e8b817b1f6630d9d562e6c))
* remove some useless heading separator ([ec8f1e9](https://github.com/msclock/cpp-scaffold/commit/ec8f1e9c4df65effdbddac43d28626d5fe983393))
* Update README.md ([3a9587c](https://github.com/msclock/cpp-scaffold/commit/3a9587ccf9feeca215fdd7884125f8d580087607))


### Tests

* configure as googletest ([912e6e2](https://github.com/msclock/cpp-scaffold/commit/912e6e255d1a9c5d7d71afadc32b18e64e918c22))
