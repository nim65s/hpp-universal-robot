if(BUILD_PYTHON_INTERFACE)
  python_install_on_site("hpp/corbaserver/ur5" "__init__.py")
  python_install_on_site("hpp/corbaserver/ur5" "robot.py")

  python_install_on_site("hpp/corbaserver/manipulation/ur5" "__init__.py")
  python_install_on_site("hpp/corbaserver/manipulation/ur5" "robot.py")
endif()
