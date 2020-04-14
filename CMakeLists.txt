# Copyright (c) 2014, 2020 CNRS
# Author: Florent Lamiraux, Guilhem Saurel
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

CMAKE_MINIMUM_REQUIRED(VERSION 3.1)

SET(PROJECT_NAME hpp-universal-robot)
SET(PROJECT_DESCRIPTION "Data specific to ur5 and 10 robots for hpp-corbaserver")

SET(PROJECT_USE_CMAKE_EXPORT TRUE)

INCLUDE(cmake/hpp.cmake)
INCLUDE(cmake/python.cmake)

COMPUTE_PROJECT_ARGS(PROJECT_ARGS LANGUAGES CXX)
PROJECT(${PROJECT_NAME} ${PROJECT_ARGS})

FINDPYTHON()

ADD_PROJECT_DEPENDENCY(example-robot-data)

ADD_LIBRARY(${PROJECT_NAME} INTERFACE)
TARGET_LINK_LIBRARIES(${PROJECT_NAME} INTERFACE example-robot-data::example-robot-data)
INSTALL(TARGETS ${PROJECT_NAME} EXPORT ${TARGETS_EXPORT_NAME} DESTINATION lib)

ADD_SUBDIRECTORY(src)
