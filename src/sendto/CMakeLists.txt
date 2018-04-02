set(sendto_NAME ${APPLICATION_EXECUTABLE}SendTo)

project(${sendto_NAME})

set(CMAKE_AUTOMOC TRUE)
set(CMAKE_AUTOUIC TRUE)
set(CMAKE_AUTORCC TRUE)

find_package(Qt5Core REQUIRED)
find_package(Qt5Widgets REQUIRED)

# Set application icon.
file(GLOB_RECURSE OWNCLOUD_ICONS "../../theme/colored/*-owncloud-icon*")
# MESSAGE( STATUS "OWNCLOUD_ICONS:         " ${OWNCLOUD_ICONS} )
ecm_add_app_icon(ICON_SOURCE ICONS "${OWNCLOUD_ICONS}" OUTFILE_BASE ${sendto_NAME} )

add_executable(${sendto_NAME} WIN32
    main.cpp
    sendtomainwindow.cpp
    sendtomainwindow.ui
    ${ICON_SOURCE}
    )

set_target_properties(${sendto_NAME} PROPERTIES
        RUNTIME_OUTPUT_DIRECTORY  ${BIN_OUTPUT_DIRECTORY} )
set_target_properties(${sendto_NAME} PROPERTIES
        INSTALL_RPATH "${CMAKE_INSTALL_PREFIX}/${LIB_INSTALL_DIR}/${APPLICATION_EXECUTABLE};${CMAKE_INSTALL_RPATH}" )

target_include_directories(${sendto_NAME} PUBLIC
    src/gui gui src/common common libsync)

target_link_libraries(${sendto_NAME} ${synclib_NAME} Qt5::Core Qt5::Network)

