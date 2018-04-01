set(sendto_NAME ${APPLICATION_EXECUTABLE}SendTo)

project(${sendto_NAME})

set(CMAKE_AUTOMOC TRUE)
set(CMAKE_AUTOUIC TRUE)
set(CMAKE_AUTORCC TRUE)

find_package(Qt5Core REQUIRED)
find_package(Qt5Widgets REQUIRED)

add_executable(${sendto_NAME}
    main.cpp
    sendtomainwindow.cpp
    sendtomainwindow.ui
    )

set_target_properties(${sendto_NAME} PROPERTIES
        RUNTIME_OUTPUT_DIRECTORY  ${BIN_OUTPUT_DIRECTORY} )
set_target_properties(${sendto_NAME} PROPERTIES
        INSTALL_RPATH "${CMAKE_INSTALL_PREFIX}/${LIB_INSTALL_DIR}/${APPLICATION_EXECUTABLE};${CMAKE_INSTALL_RPATH}" )

target_include_directories(${sendto_NAME} PUBLIC
    src/gui gui src/common common libsync)

target_link_libraries(${sendto_NAME} ${synclib_NAME} Qt5::Core Qt5::Network)

#set(MIRALL_RC_SRC ../../client.qrc)
#if (EXISTS "${OEM_THEME_DIR}/theme.qrc")
#    list(APPEND MIRALL_RC_SRC ${OEM_THEME_DIR}/theme.qrc)
#    set(theme_dir ${OEM_THEME_DIR}/theme)
#else()
#    list(APPEND MIRALL_RC_SRC ../../theme.qrc)
#    set(theme_dir ${CMAKE_SOURCE_DIR}/theme)
#endif()


#set(SendTo_NAME ${APPLICATION_EXECUTABLE}SendTo)

#set(SendTo_UI_SRCS
#    sendtomainwindow.ui )

#set(SendTo_SRC
#    main.cpp
#    sendtomainwindow.cpp )

#set( final_src
#    ${MIRALL_RC_SRC}
#    ${SendTo_UI_SRCS}
#    ${SendTo_SRC}
#    ${guiMoc}
#)

#if(UNIX AND NOT APPLE)
#  set(CMAKE_C_FLAGS "${CMAKE_C_FLAGS} -fPIE")
#  set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -fPIE")
#  set(CMAKE_EXE_LINKER_FLAGS "${CMAKE_EXE_LINKER_FLAGS} -pie")
#endif()

#if(NOT BUILD_LIBRARIES_ONLY)
#    if(QTKEYCHAIN_FOUND OR QT5KEYCHAIN_FOUND)
#        list(APPEND libsync_LINK_TARGETS ${QTKEYCHAIN_LIBRARY})
#        include_directories(${QTKEYCHAIN_INCLUDE_DIR})
#    endif()
#    if (NOT DEFINED APPLICATION_ICON_NAME)
#        set(APPLICATION_ICON_NAME ${APPLICATION_SHORTNAME})
#    endif()
#    file(GLOB_RECURSE OWNCLOUD_ICONS "${theme_dir}/colored/*-${APPLICATION_ICON_NAME}-icon*")
#    if(APPLE)
#        file(GLOB_RECURSE OWNCLOUD_SIDEBAR_ICONS "${theme_dir}/colored/*-${APPLICATION_ICON_NAME}-sidebar*")
#        MESSAGE(STATUS "OWNCLOUD_SIDEBAR_ICONS: ${APPLICATION_ICON_NAME}: ${OWNCLOUD_SIDEBAR_ICONS}")
#    endif()
#    ecm_add_app_icon(final_src ICONS "${OWNCLOUD_ICONS}" SIDEBAR_ICONS "${OWNCLOUD_SIDEBAR_ICONS}" OUTFILE_BASE "${APPLICATION_ICON_NAME}")

#    add_executable(${SendTo_NAME} WIN32 ${SendTo_SRC} ${final_src} )
#    set_target_properties(${SendTo_NAME} PROPERTIES
#            RUNTIME_OUTPUT_DIRECTORY  ${BIN_OUTPUT_DIRECTORY} )
#    set_target_properties(${SendTo_NAME} PROPERTIES
#            INSTALL_RPATH "${CMAKE_INSTALL_PREFIX}/${LIB_INSTALL_DIR}/${APPLICATION_EXECUTABLE};${CMAKE_INSTALL_RPATH}" )

#    target_link_libraries(${SendTo_NAME} ocsync ${synclib_NAME} Qt5::Core Qt5::Network)

#    # Need tokenizer for netrc parser
#    target_include_directories(${SendTo_NAME} PRIVATE ${CMAKE_SOURCE_DIR}/src/3rdparty/qtokenizer)
#endif()

#if(BUILD_OWNCLOUD_OSX_BUNDLE)
#    install(TARGETS ${SendTo_NAME} DESTINATION ${OWNCLOUD_OSX_BUNDLE}/Contents/MacOS)
#elseif(NOT BUILD_LIBRARIES_ONLY)
#    install(TARGETS ${SendTo_NAME}
#	    RUNTIME DESTINATION ${CMAKE_INSTALL_BINDIR}
#	    LIBRARY DESTINATION ${CMAKE_INSTALL_LIBDIR}
#	    ARCHIVE DESTINATION ${CMAKE_INSTALL_LIBDIR})
#endif()

## FIXME: The following lines are dup in src/gui and src/SendTo because it needs to be done after both are installed
##FIXME: find a nice solution to make the second if(BUILD_OWNCLOUD_OSX_BUNDLE) unnecessary
## currently it needs to be done because the code right above needs to be executed no matter
## if building a bundle or not and the install_qt4_executable needs to be called afterwards
#if(BUILD_OWNCLOUD_OSX_BUNDLE AND NOT BUILD_LIBRARIES_ONLY)
#   get_target_property (QT_QMAKE_EXECUTABLE Qt5::qmake IMPORTED_LOCATION)
#   install(CODE "
#    message(STATUS \"Deploying (Qt) dependencies and fixing library paths...\")
#    execute_process(COMMAND \"${CMAKE_SOURCE_DIR}/admin/osx/macdeployqt.py\" ${CMAKE_INSTALL_PREFIX}/${OWNCLOUD_OSX_BUNDLE} ${QT_QMAKE_EXECUTABLE})
#    " COMPONENT RUNTIME)
#endif()
