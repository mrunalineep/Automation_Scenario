# RobotFramework

This README.md provides a clear and comprehensive guide for users and contributors to understand, set up, and work with your Robot Framework project. Make sure to customize it based on the specifics of your project.


## Table of Contents

[Installation](#installation)
[Running Tests](#running-tests)
[Centralized Documentation](#centralized-documentation)


### Prerequisites

Python 3.10 or above
pip (Python package installer)

### Steps

1. Clone the repository:

   sh
     git clone https://github.com/gorakhsawantindexnine/RobotFramework.git
   
     cd RobotFramework
   
2. Install the Robot Framework and other dependencies:

   pip install -r requirements.txt

## Running Tests

To run the tests, use the following command:

### Sequential Execution using Robot
sh
robot --outputdir Output/ TestCases/Login/
                # or
robot --outputdir Output/ TestCases/

### Parallel Execution using Robot
sh
pabot --testlevelsplit --processes 4 --outputdir Output/ TestCases

### Links for  :
   - Execution Commands: https://drive.google.com/file/d/1WxzDyejfWnodBhAe1JXDCtDxDFTODdrq/view?usp=drive_link

   - Installation Setup: https://drive.google.com/file/d/1lfb_tYRnxtIUGe7KOzJE4bXBLMlRxt_W/view?usp=drive_link
