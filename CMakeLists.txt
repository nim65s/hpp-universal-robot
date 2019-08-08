# Copyright (c) 2014 CNRS
# Author: Florent Lamiraux
#
# This file is part of hpp-universal-robot.
# hpp-universal-robot is free software: you can redistribute it
# and/or modify it under the terms of the GNU Lesser General Public
# License as published by the Free Software Foundation, either version
# 3 of the License, or (at your option) any later version.
#
# hpp-universal-robot is distributed in the hope that it will be
# useful, but WITHOUT ANY WARRANTY; without even the implied warranty
# of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
# General Lesser Public License for more details.  You should have
# received a copy of the GNU Lesser General Public License along with
# hpp-universal-robot.  If not, see
# <http://www.gnu.org/licenses/>.

# Requires at least CMake 2.6 to configure the package.
CMAKE_MINIMUM_REQUIRED(VERSION 2.6)

INCLUDE(cmake/base.cmake)
INCLUDE(cmake/hpp.cmake)
INCLUDE(cmake/hpp/python.cmake)

FIND_PROGRAM(XACRO_EXECUTABLE xacro)

# GENERATE_URDF_FILE FILENAME EXTENSION
# ------------------------------------
#
# Generate urdf ${CMAKE_CURRENT_BINARY_DIR}/${FILENAME}.${EXTENSION}
# from xacro ${CMAKE_CURRENT_SOURCE_DIR}/${FILENAME}.xacro file.
#
# To trigger generation, use:
# ADD_CUSTOM_TARGET (generate_urdf_files DEPENDS ${ALL_GENERATED_URDF})
#
# FILENAME : XACRO filename without the extension
#
# Note : If ${CMAKE_CURRENT_SOURCE_DIR}/${FILENAME}.xacro does not exists,
#        the macros tries to configure file ${CMAKE_CURRENT_SOURCE_DIR}/${FILENAME}.xacro.in
#
MACRO(GENERATE_URDF_FILE FILENAME)
  SET(_XACRO_FILE_ ${UR_DESCRIPTION_PREFIX}/share/ur_description/${FILENAME}.xacro)
  IF (NOT EXISTS ${_XACRO_FILE_})
    MESSAGE(FATAL_ERROR "cannot find \"${_XACRO_FILE_}\"")
  ENDIF (NOT EXISTS ${_XACRO_FILE_})

  ADD_CUSTOM_COMMAND(
    OUTPUT ${FILENAME}
    COMMAND ${XACRO_EXECUTABLE}
    ARGS -o ${FILENAME} ${_XACRO_FILE_}
    MAIN_DEPENDENCY ${_XACRO_FILE_}
    COMMENT "Generating ${FILENAME} from ${_XACRO_FILE_}"
    )
  LIST(APPEND ALL_GENERATED_URDF ${FILENAME})

  # Clean generated files.
  SET_PROPERTY(
    DIRECTORY APPEND PROPERTY
    ADDITIONAL_MAKE_CLEAN_FILES
    ${OUTPUT_FILE}
    )

  LIST(APPEND LOGGING_WATCHED_VARIABLES ALL_GENERATED_URDF)
ENDMACRO(GENERATE_URDF_FILE FILENAME CONFIGURE)


SET(PROJECT_NAME hpp-universal-robot)
SET(PROJECT_DESCRIPTION
  "Data specific to ur5 and 10 robots for hpp-corbaserver")

SETUP_HPP_PROJECT()

HPP_FINDPYTHON()

ADD_REQUIRED_DEPENDENCY ("ur_description >= 1")

# Generate urdf files from xacro files
MAKE_DIRECTORY(urdf)
SET(XACRO_FILES
  urdf/ur5_joint_limited_robot.urdf
  )
FOREACH(it ${XACRO_FILES})
 GENERATE_URDF_FILE (${it})
ENDFOREACH(it)
ADD_CUSTOM_TARGET (generate_urdf_file ALL DEPENDS ${ALL_GENERATED_URDF})
# Install files
SET (UR_DESCRIPTION_DATAROOTDIR ${CMAKE_INSTALL_PREFIX}/share/ur_description)

INSTALL(FILES
  ${CMAKE_BINARY_DIR}/urdf/ur5_joint_limited_robot.urdf
  DESTINATION ${UR_DESCRIPTION_DATAROOTDIR}/urdf
  )


INSTALL(FILES
  ${PROJECT_SOURCE_DIR}/src/hpp/corbaserver/ur5/robot.py
  ${PROJECT_SOURCE_DIR}/src/hpp/corbaserver/ur5/__init__.py
  DESTINATION ${PYTHON_SITELIB}/hpp/corbaserver/ur5
)

INSTALL(FILES
  ${PROJECT_SOURCE_DIR}/src/hpp/corbaserver/manipulation/ur5/robot.py
  ${PROJECT_SOURCE_DIR}/src/hpp/corbaserver/manipulation/ur5/__init__.py
  DESTINATION ${PYTHON_SITELIB}/hpp/corbaserver/manipulation/ur5
)

INSTALL(FILES
  ${PROJECT_SOURCE_DIR}/share/ur_description/srdf/ur3_gripper.srdf
  ${PROJECT_SOURCE_DIR}/share/ur_description/srdf/ur5.srdf
  ${PROJECT_SOURCE_DIR}/share/ur_description/srdf/ur5_joint_limited_robot.srdf
  ${PROJECT_SOURCE_DIR}/share/ur_description/srdf/ur5_gripper.srdf
  DESTINATION ${UR_DESCRIPTION_DATAROOTDIR}/srdf
)

INSTALL(FILES
  ${PROJECT_SOURCE_DIR}/share/ur_description/urdf/ur3_gripper.urdf
  ${PROJECT_SOURCE_DIR}/share/ur_description/urdf/ur5_gripper.urdf
  DESTINATION ${UR_DESCRIPTION_DATAROOTDIR}/urdf
)

INSTALL(FILES
  ${PROJECT_SOURCE_DIR}/launch/ur5.launch
  DESTINATION ${UR_DESCRIPTION_DATAROOTDIR}/launch
)

INSTALL(FILES
  ${PROJECT_SOURCE_DIR}/share/rviz/config.rviz
  DESTINATION ${UR_DESCRIPTION_DATAROOTDIR}/rviz
)

SETUP_HPP_PROJECT_FINALIZE()
