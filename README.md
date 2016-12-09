# info201-final-project
## Danish Bashar, Davis Huynh, Mohammed Hariz, Ryan Mills

### Shiny URL: https://negativerainbow.shinyapps.io/info201-final-project/

Please do not switch tabs before graphs finish loading, it makes them break when you go back to that tab.  
If the shiny server gives you an error, please clone the github repository and run the code locally.

### Directory Structure:

* Data and Data Sanitization R file are in "data" folder
* Tab and Chart/Graph scripts are in "scripts" folder
* CSS Stylesheet is in "www" folder

### Description of Project as found in "About Our Project" tab

#### Target Audience

Patients that are worried that their doctors may be suffering a conflict of interest between giving them the best care possible and financial gains from pharmaceutical companies

#### About the Data

We were watching a [John Oliver video](https://www.youtube.com/watch?v=YQZ2UeOTO3I) about free gifts given by pharmaceutical companies to doctors, which often has an impact on the prescriptions that doctors end up making. When the Affordable Care Act was made law, it stipulated that the US government had to collect data on every single transaction made between these companies and doctors. We took the data from the three years since the act was put into place (about 6gb per year) and filtered it down to data just about recipients in Washington State (cutting down the file size to about 60mb per year). Each row of the data specifies one transaction between a pharmaceutical company and a doctor/hospital, with various details such as the date, the recipient, the donor, what drugs the company is tied to, and more. We took this data and analyzed it into the other tabs, check those for more information about what they do.
