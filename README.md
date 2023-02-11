# brew_crew

### structures
                  provider(Auth Change Stream for state management)
                MyApp (root)
            Wrapper (listen to auth changes)
 (not logged in)                    (loggedin)
 Authentication                         Home   
Signin      Register             BrewList   Settings

### User Data
                   User Data
              New user registers(new account)
        create new record in the 'brews' collection for that user
                name, sugars, strength


### Tourbleshooting
    Error: Cannot run with sound null safety, because the following dependencies
    don't support null safety:

    - package:firebase_auth
    - package:firebase_core
    - package:firebase_core_platform_interface
    - package:plugin_platform_interface
    - package:quiver

    Run 'flutter run --no-sound-null-safety'

