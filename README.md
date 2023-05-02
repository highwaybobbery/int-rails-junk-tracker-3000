# Junk Tracker 3000

You have been hired to build an inventory management system for your local junkyard! While they accept may different items, old vehicles are their most popular, so in addition to just tracking what's in stock, they also want to run up-to-date ads for everything they have.

## Tasks

1. Allow for four different vehicle types (listed below) to be created, updated and destroyed with the attributes described below.
    - The starter code has a some UI components laid out, but you'll need to make them functional.
2. After each vehicle is created, register it using the [`VehicleRegistrationService`](app/services/vehicle_registration_service.rb) and permanently associate that registration ID with the vehicle.
3. Whenever a vehicle is created or updated, create or update a text advertisement for the vehicle using the [`VehiclePromotionService`](app/services/vehicle_promotion_service.rb) to promote the vehicle to the public.
    - When an advertiserment is first created an ID is returned to reference the created advertisemend. That ID should be used when updating an advertiserment for a partiuclar verhicle whenever its details are updated.
    - Use [`AdBuilder`](app/services/ad_builder.rb) to generate text advertiserments for vehicles. [`ad_builder_spec.rb`](spec/ad_builder_spec.rb) contains failing tests that describe what those text ads should look like. Implement `AdBuilder.create_ad` so that all of the existing tests pass
        - We use [RSpec](https://rspec.info/), but if you're more comfortable with other testing frameworks or tools feel free to use those instead.
4. List all vehicles on `http://localhost:3000/vehicles` with their 
    - type
    - nickname
    - registration ID

### Vehicle Types

- Sedan
    - Nickname: string
    - Mileage: integer
    - Doors: 0-4, default: 4
    - Engine status: works, fixable, junk, default: works
- Coupe
    - Nickname: string
    - Mileage: integer
    - Doors: 0-2, default: 2
    - Engine status: works, fixable, junk, default: works
- Mini-Van
    - Nickname: string
    - Mileage: integer
    - Doors: 0-4, default: 4
      - For each door: 
        - Sliding: boolean, default: false 
    - Engine status: works, fixable, junk, default: works
- Motorcycle
    - Nickname: string
    - Mileage: integer
    - Engine status: works, fixable, junk, default: works
    - Seat status: works, fixable, junk, default: works

## Guildelines

**Please don't spend more than two (2) hours on this project!**

The goal is not to add every bell, whistle, feature and optimization that you can think of. The goal is to both see an example of working code that you write and see how you do implementing realistic (albeit contrived...) features. 

You will be judged on how accurately you complete the above tasks and the quality of the code you write (including tests). 

The Rails app already has some scaffolding for a Vehicle model as an example. You are free to make any and all changes you'd like to complete the assignment.

## Getting Started

See [`SETUP.md`](SETUP.md) for instructions on how to get your development envrionment working. If you have any questions, especially regarding setup, please contact us so we can get it sorted out ASAP!

When you are finished, push all changes to the repo on GitHub and email us that you've finished! Feel free to to open a pull request or leave any other comments on specific commits or the repo as you see fit.

## Notes

- If you have any issues at all, especially with getting your development environment working, please reach out to us ASAP. Our intention isn't to make you troubleshoot an existing project's configuration. (You wouldn't spend the majority of your work day doing that in real life). We are more than happy to do that for you!
- Make your first priority getting everything to work! Save the bonus points for after you get things working all the way through.
- Do not worry about server-side rendering of any JavaScript React components
- Feel free to turn off CSRF protection to keep things simple
- Add any additional ruby gems, npm modules or other tools you'd like
