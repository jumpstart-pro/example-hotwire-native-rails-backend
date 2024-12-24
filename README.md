# Hotwire Native Rails back-end example app

This example app includes everything you need to get up and running with the [Jumpstart Pro iOS](https://jumpstartrails.com/ios) template.

You can start with this repository as a template for your Rails codebase or copy/paste the needed code into your existing app.

## Overview

The app is a blogging example with limited functionality. You can perform CRUD operation on `Post` objects and sign in/out via Devise.

Creating, updating, or deleting blog posts requires you to be signed in.

## Installation

To run the example, perform the following:

 * Clone the repo
 * run `bundle install`
 * run `bin/rails db:create db:migrate`
 * run `bin/rails server`
 * Visit `localhost:3000` in your browser, app should be running

## Path Configuration

The `PathConfigurationsController` configures the settings and tabs for your app.

### Dynamic native tabs

Adding more hashes under the `tabs:` key will add new native tabs to the app the next time it is launched.

See the Jumpstart Pro iOS documentation on more information on more configuration options.

## Authentication

The Hotwire Native client uses cookie authentication just like the browser.

Upon successful auth, `after_sign_in_path_for` is set in `ApplicationController` to redirect to `/reset_app` for Hotwire Native apps. This renders an empty HTML template which the app "catches" to reset the state of the app (like tabs and reload the path configuration).

### Signing out

Sending a DELETE request to `/api/v1/auth` signs the user out (resets the cookies) and deletes the associated notification token.

HTML links to sign out are "trapped" via a Stimulus controller to ensure the request is sent from the app. See `bridge--sign-out` on how this click is hijacked and a JavaScript message is sent to the iOS app to kick off the flow.

## Push notifications

Add a `bridge--notification-token` data attribute to have the app POST the device's notification token to `/api/v1/notification_tokens` (with the user's permission). This is persisted to the `NotificationToken` model and associated with the `User`.

An example push notification is set up powered by [Noticed](https://github.com/excid3/noticed) (and [Apnotic](https://github.com/ostinelli/apnotic)). See `NewPostNotification`.

To get this working in your app you will need to follow a few steps.

1. Ensure that you have an active Apple Developer Program subscription.
2. Register your app's bundle identifier making sure to check APNS (Push Notifications) capability.
3. [Generate an APNs .p8 file from your Apple Developer portal](https://developer.apple.com/account/resources/authkeys/list).
4. Copy the generated .p8 file to `config/certs/ios/apns.p8`.
5. Add the following credentials to the necessary environments.

```yaml
ios:
  key_id: # Shown before you download the .p8 key.
  team_id: # In the upper-right of App Store Connect.
  bundle_identifier: # The dot-separated identifier of your app, configured in Xcode.
```
