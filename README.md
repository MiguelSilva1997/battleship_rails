# README

## Timeline
I took approximately 3:00 hrs to finish this challenge. Spent around 30 minutes planning and the rest implementing the logic. I think I could of finished quicker but I only have short periods of time to work on each commit. Gaining all of the context back was probably what took me most of the time.

## Improvements
### Testing 
  Would of love to introduce more testing in certain pieces but had to conform with some integration testing.
  Cleaning some of the automation would of also been great but for an MVP it accomplishes the goal.
  
### File Structure
  Added the helper modules inside the models files. If I would of taken a bit more time I would of try to clean that up.
  From this:
  ```
  -app
    |
     models
       |
        *_helper.rb
  ```
  to this:
  ```
  -app
    |
    -models
       | 
      -ships
       |
          - ship_helper.rb
  ```
  I study the idea of creating a lib folder inside the app but that really is just moving the mess to two places and I believe with the desired integration we weill achieve to control the mess and help future devs realize where the helper methods are.

### Schema
Decided to go with a schema were we only build a Game, Turn, Ship table.
Since we are only building the backend portion I saw no need to build a board. With the turns and ship we can easily recreate the table for the frontend. It will only require to take all the turns and ships to build it accordingly.
  #### Reason:
   When I studied the idea of building a board and storing it as a JSON blob. I thought that it will be hard to maintain. Specially if the board was to change or    we were to implement a look back to a past game service. (Like Chess)
   
   While the game table has the name saved. I decided to append a uuid at the end. I added the hashtag to make sure the frontend had a way to just display the name if need be. This add a unique identifier for the user specially if they have the same name.
   
   For MVP reasons decided to opt out of adding a user table. It could of been probably easier but at the time I wanted to make it as realistic as a real life scenario as possible. Sometimes you have to only pick the good idea not the best.
   
   Decided to change the Rails default id for the Game table and make it session_id since it will be less confusing.
   
### Bugs
  I think there is certain bugs but try to minimize them by creating unique constraints in the database.
  One Cons of the Ship table storing the coordinates as a string is that if input at the same time (different windowns) they might be a chance of duplicates.
  As of right now the user cannot be stop from taking a hit when the game phase is in setup mode. That was just do to the time limit. Even though is very trivial to add.
  
## Conclusion
  Certain things might slip my mind but this is the most recent revision. I am glad I could get this functional after a very hectic week at work. I might revise this a little more and probably make it part of my presentation to the kids from a nearby school for career day. Hope to convince them to join the tech world.
    
