ui by :

1. https://dribbble.com/shots/20621876-OZI-messenger-app
2. https://dribbble.com/shots/19044015-Messenger-app
3. https://dribbble.com/shots/22589252-Forex-Sign-Up-Screens
4. https://public-images.interaction-design.org/literature/articles/materials/8a2iV6RBKVI0jOVi1iV2cB1u2M5gpGKAEN1kC84o.jpg
5. https://dribbble.com/shots/21403245-Social-Media-App-UI

in order to to facebook auth check out this like:

1. https://www.youtube.com/watch?v=Q61d-Ag13eU


for ios in order to add google sign in add 
go the google website:

https://developers.google.com/identity/sign-in/ios/start-integrating?hl=ru#add_a_url_scheme_for_google_sign-in_to_your_project

and create id for your project for IOS

then add this line in your Info.plis:

    <key>CFBundleURLTypes</key>
    <array>
        <dict>
            <key>CFBundleTypeRole</key>
            <string>Editor</string>
            <key>CFBundleURLSchemes</key>
            <array>
                <string>YOUR_IOS_BUNDLE_ID</string>
            </array>
        </dict>
        <dict>
            <key>CFBundleTypeRole</key>
            <string>Editor</string>
            <key>CFBundleURLSchemes</key>
            <array>
                <string>com.googleusercontent.apps.GENERATED_ID_HERE</string>
            </array>
        </dict>
        <dict>
            <key>CFBundleTypeRole</key>
            <string>Editor</string>
            <key>CFBundleURLSchemes</key>
            <array>
                <string>***Something here***</string>
            </array>
        </dict>
    </array>


for ios:

    <key>CFBundleURLTypes</key>
    <array>
      <dict>
      <key>CFBundleURLSchemes</key>
      <array>
        <string>fbAPP-ID</string>
      </array>
      </dict>
    </array>
    <key>FacebookAppID</key>
    <string>APP-ID</string>
    <key>FacebookClientToken</key>
    <string>CLIENT-TOKEN</string>
    <key>FacebookDisplayName</key>
    <string>APP-NAME</string>


for more information about facebook and google ath take a look to the
android and ios folder -> AndroidManifest.xml and Info.plist