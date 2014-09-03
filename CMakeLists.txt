cmake_minimum_required(VERSION 2.8)

project(paperbark)

find_program(BASH_EXEC bash)
find_program(GIT_EXEC git)
#if(NOT ${BASH_EXEC} OR NOT ${GIT_EXEC})
    #message(FATAL_ERROR "command 'bash' and 'git' are mandatory")
#endif()

install(
    FILES
        scripts/config
        scripts/pbadmin-cmd-init
        scripts/pbadmin-utils
        scripts/pb-cmd-export
        scripts/pb-cmd-import
        scripts/pb-cmd-init
        scripts/pb-cmd-list
        scripts/pb-cmd-list-snapshot
        scripts/pb-cmd-pull
        scripts/pb-cmd-push
        scripts/pb-cmd-remote
        scripts/pb-cmd-remove
        scripts/pb-cmd-remove-snapshot
        scripts/pb-cmd-rename
        scripts/pb-cmd-run
        scripts/pb-cmd-search
        scripts/pb-cmd-snapshot
        scripts/pbentry-pbadmin
        scripts/pbentry-pbtunnel
        scripts/pbentry-post-update
        scripts/pbtunnel
        scripts/pbtunnel-cmd-pull
        scripts/pbtunnel-cmd-push
        scripts/pbtunnel-cmd-remove
        scripts/pbtunnel-cmd-search
        scripts/remote
        scripts/ssh
        scripts/suentry-pb
        scripts/utils
        scripts/zfs
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
configure_file(scripts/pbentry.in pbentry @ONLY)

set(CPACK_GENERATOR "DEB")
set(CPACK_PACKAGE_DESCRIPTION ${PACKAGE_DESCRIPTION})
set(CPACK_PACKAGE_DESCRIPTION_SUMMARY ${PACKAGE_DESCRIPTION})
set(CPACK_PACKAGE_VENDOR ${PACKAGE_MAINTAINER})
set(CPACK_PACKAGE_VERSION ${PACKAGE_VERSION})
set(CPACK_PACKAGE_FILE_NAME ${CMAKE_PROJECT_NAME}-${PACKAGE_VERSION})
set(CPACK_COMPONENTS_ALL_IN_ONE_PACKAGE 1)

set(CPACK_DEBIAN_PACKAGE_MAINTAINER ${PACKAGE_MAINTAINER})
set(CPACK_DEBIAN_PACKAGE_DEPENDS "pv, ssh, lbzip2, util-linux (>=2.20), ubuntu-zfs | zfs (>=0.6.3), sudo, bash (>=4.2)")
set(CPACK_DEBIAN_PACKAGE_ARCHITECTURE all)
set(CPACK_DEBIAN_PACKAGE_SECTION Development)
set(CPACK_DEBIAN_PACKAGE_CONTROL_EXTRA ${CMAKE_SOURCE_DIR}/debian/postinst)

include(CPack)
