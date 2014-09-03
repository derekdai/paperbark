cmake_minimum_required(VERSION 2.8)

project(paperbark)

find_program(BASH_EXEC bash)
find_program(GIT_EXEC git)
#if(NOT ${BASH_EXEC} OR NOT ${GIT_EXEC})
    #message(FATAL_ERROR "command 'bash' and 'git' are mandatory")
#endif()

install(
    FILES
        bin/config
        bin/pbadmin-cmd-init
        bin/pbadmin-utils
        bin/pb-cmd-export
        bin/pb-cmd-import
        bin/pb-cmd-init
        bin/pb-cmd-list
        bin/pb-cmd-list-snapshot
        bin/pb-cmd-pull
        bin/pb-cmd-push
        bin/pb-cmd-remote
        bin/pb-cmd-remove
        bin/pb-cmd-remove-snapshot
        bin/pb-cmd-rename
        bin/pb-cmd-run
        bin/pb-cmd-search
        bin/pb-cmd-snapshot
        bin/pbentry-pbadmin
        bin/pbentry-pbtunnel
        bin/pbentry-post-update
        bin/pbtunnel
        bin/pbtunnel-cmd-pull
        bin/pbtunnel-cmd-push
        bin/pbtunnel-cmd-remove
        bin/pbtunnel-cmd-search
        bin/remote
        bin/ssh
        bin/suentry-pb
        bin/utils
        bin/zfs
    DESTINATION
        share/paperbark
)

install(PROGRAMS ${CMAKE_BINARY_DIR}/pbentry DESTINATION share/paperbark)
install(
    FILES
        ${CMAKE_BINARY_DIR}/pb
        ${CMAKE_BINARY_DIR}/pbadmin
    DESTINATION
        bin
)

set(PACKAGE_MAINTAINER "Derek Dai <daiderek@gmail.com>")
set(PACKAGE_DESCRIPTION "a versioned filesystem manager based on zfsonlinux")

execute_process(COMMAND cmake -E create_symlink ../share/paperbark/pbentry pb
                COMMAND cmake -E create_symlink ../share/paperbark/pbentry pbadmin
)
execute_process(COMMAND git describe OUTPUT_VARIABLE PACKAGE_VERSION)
string(SUBSTRING "${PACKAGE_VERSION}" 1 -1 PACKAGE_VERSION)
string(STRIP "${PACKAGE_VERSION}" PACKAGE_VERSION)
configure_file(bin/pbentry.in pbentry @ONLY)

set(CPACK_GENERATOR "DEB")
set(CPACK_PACKAGE_DESCRIPTION ${PACKAGE_DESCRIPTION})
set(CPACK_PACKAGE_DESCRIPTION_SUMMARY ${PACKAGE_DESCRIPTION})
set(CPACK_PACKAGE_VENDOR ${PACKAGE_MAINTAINER})
set(CPACK_PACKAGE_VERSION ${PACKAGE_VERSION})
set(CPACK_PACKAGE_FILE_NAME ${CMAKE_PROJECT_NAME}-${PACKAGE_VERSION})

set(CPACK_DEBIAN_PACKAGE_MAINTAINER ${PACKAGE_MAINTAINER})
set(CPACK_DEBIAN_PACKAGE_DEPENDS "pv, ssh, lbzip2, util-linux (>=2.20), ubuntu-zfs | zfs (>=0.6.3), sudo, bash (>=4.2)")
set(CPACK_DEBIAN_PACKAGE_ARCHITECTURE all)
set(CPACK_DEBIAN_PACKAGE_SECTION Development)

include(CPack)
