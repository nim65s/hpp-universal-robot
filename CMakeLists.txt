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

SET(PROJECT_NAME hpp-universal-robot)
SET(PROJECT_DESCRIPTION
  "Data specific to ur5 and 10 robots for hpp-corbaserver")

SETUP_HPP_PROJECT()

HPP_FINDPYTHON()

ADD_REQUIRED_DEPENDENCY ("example-robot-data >= 2.2.0")

# Install files
SET (UR_DESCRIPTION_DATAROOTDIR ${CMAKE_INSTALL_PREFIX}/share/example-robot-data/ur_description)

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
