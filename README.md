## Requirements
Python
Pip


## Setup

Install virtual env using `pip install virtualenv` and create a new virtual environment, using `py -m venv env`

You should also activate your environment, which for Windows can be done by using the command `.\env\Scripts\activate`, and then you can simply run `pip install -r requirements.txt` to install all dependencies required for the project.

You should also install a Web Driver, such as google web driver, following the steps on https://chromedriver.chromium.org/getting-started

You need to add this new web driver executable to your PATH, in Windows you can do so by moving the downloaded `chromedriver.exe` file
to the `%SystemRoot%` folder.


## Execution

To run all tests we can execute the robot command:

```
robot CalculatorMainTestCases.robot
```

We can also run specific Tags to run parts of the test suite.
Available Tags are: 
1. Home Energy
2. Transportation
3. Waste
4. Start Over
5. Report
6. Calculator

The tags can be used to select tests running the following command:
```
robot -i <tag-name> CalculatorMainTestCases.robot
```
