# Copyright (c) 2014, 2020 CNRS Author: Florent Lamiraux, Guilhem Saurel
#
# This file is part of hpp-universal-robot. hpp-universal-robot is free
# software: you can redistribute it and/or modify it under the terms of the GNU
# Lesser General Public License as published by the Free Software Foundation,
# either version 3 of the License, or (at your option) any later version.
#
# hpp-universal-robot is distributed in the hope that it will be useful, but
# WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
# FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Lesser Public License
# for more details.  You should have received a copy of the GNU Lesser General
# Public License along with hpp-universal-robot.  If not, see
# <http://www.gnu.org/licenses/>.

cmake_minimum_required(VERSION 3.10)

set(PROJECT_NAME hpp-universal-robot)
set(PROJECT_DESCRIPTION
    "Data specific to ur5 and 10 robots for hpp-corbaserver")

set(PROJECT_USE_CMAKE_EXPORT TRUE)

include(cmake/hpp.cmake)
include(cmake/python.cmake)

compute_project_args(PROJECT_ARGS LANGUAGES CXX)
project(${PROJECT_NAME} ${PROJECT_ARGS})

findpython()

add_project_dependency(example-robot-data)

add_library(${PROJECT_NAME} INTERFACE)
target_link_libraries(${PROJECT_NAME}
                      INTERFACE example-robot-data::example-robot-data)
install(
  TARGETS ${PROJECT_NAME}
  EXPORT ${TARGETS_EXPORT_NAME}
  DESTINATION lib)

add_subdirectory(src)

install(FILES package.xml DESTINATION share/${PROJECT_NAME})
