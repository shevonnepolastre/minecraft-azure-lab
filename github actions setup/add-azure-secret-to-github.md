# Adding Azure Secret to GitHub

This guide walks you through adding your Azure app secret to GitHub to use runner 

## Prerequisites

- Access to a GitHub repository
- Created runner 

## Setting it Up 

- In Azure, create an app registration (You can follow this [guide](https://learn.microsoft.com/en-us/training/modules/test-bicep-code-using-github-actions/4-exercise-set-up-environment?pivots=powershell)
- Create a managed identity (Use same guide)
- In GitHub, go to Settings -> Security and Variables -> Actions
- The guide says to enter the Client ID, Tenant ID, and Subscription ID, separately but it's better to do it this way:

  ```yaml

   {
    "clientId": "xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx",
    "subscriptionId": "yyyyyyyy-yyyy-yyyy-yyyy-yyyyyyyyyyyy",
    "tenantId": "zzzzzzzz-zzzz-zzzz-zzzz-zzzzzzzzzzzz"
  }
'''
