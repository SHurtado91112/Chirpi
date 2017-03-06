# Project 4 - *Chirpi*
## *A Twitter Clone*
![chirpilogo_small](https://cloud.githubusercontent.com/assets/11231583/23326859/27f3f01c-fad1-11e6-81fa-5b762c685b5e.png)

**Chirpi** is a basic twitter app to read and compose tweets the [Twitter API](https://apps.twitter.com/).

Time spent: **24** hours spent in total

## User Stories

The following **required** functionality is completed:

### Week 1
- [X] User can sign in using OAuth login flow
- [X] User can view last 20 tweets from their home timeline
- [X] The current signed in user will be persisted across restarts
- [X] In the home timeline, user can view tweet with the user profile picture, username, tweet text, and timestamp.
- [X] Retweeting and favoriting should increment the retweet and favorite count.

### Week 2
- [X] Tweet Details Page: User can tap on a tweet to view it, with controls to retweet, favorite, and reply.
- [X] Profile page:
   - [X] Contains the user header view
   - [X] Contains a section with the users basic stats: # tweets, # following, # followers
- [X] Home Timeline: Tapping on a user image should bring up that user's profile page
- [X] Compose Page: User can compose a new tweet by tapping on a compose button.

The following **optional** features are implemented:

### Week 1
- [X] User can load more tweets once they reach the bottom of the feed using infinite loading similar to the actual Twitter client.
- [X] User should be able to unretweet and unfavorite and should decrement the retweet and favorite count.
- [X] User can pull to refresh.

### Week 2
- [X] When composing, you should have a countdown in the upper right for the tweet limit.
- [X] After creating a new tweet, a user should be able to view it in the timeline immediately without refetching the timeline from the network.
- [ ] Profile Page
   - [X] Implement the paging view for the user description.
   - [ ] As the paging view moves, increase the opacity of the background screen. See the actual Twitter app for this effect
   - [ ] Pulling down the profile page should blur and resize the header image.
- [ ] Account switching
   - [ ] Long press on tab bar to bring up Account view with animation
   - [ ] Tap account to switch to
   - [ ] Include a plus button to Add an Account
   - [ ] Swipe to delete an account

The following **additional** features are implemented:

### Week 1
- [X] Spring animated splash screen and login screen.
- [X] Elapsed time for each tweet is formatted.
- [X] Retweet/Favorite counts are formatted.
- [X] Border color of each user's avatar is their selected Twitter profile color
- [X] Shows if tweet online was retweeted and by whom it was created
- [X] Formats text appropriately
- [X] Animate retweet and favorite button
- [X] Parses media_url text from tweet and replaces with media image associated with that url

### Week 2
- [X] Current User Profile Timeline
- [X] Image View in Tweet cell with media
- [X] UI Updates and Animation for composing tweet
- [X] Segue destination through clicking image view
    - [X] UITapGestureRecognizer subclass to segue based on image touch

Please list two areas of the assignment you'd like to **discuss further with your peers** during the next class (examples include better ways to implement something, how to extend your app in certain ways, etc):

1. Handling other forms of media; i.e. video, webpages, replies
2. Direct messaging

## Video Walkthrough 

Here's a walkthrough of implemented user stories:

### Week 1
![chirpigif1](https://cloud.githubusercontent.com/assets/11231583/23343278/951576aa-fc36-11e6-8bda-dc01f9b26c40.gif)

### Week 2
![chirpigif2](https://cloud.githubusercontent.com/assets/11231583/23593399/8c7cba70-01dc-11e7-9d79-f41a6a93a962.gif)

GIF created with [LiceCap](http://www.cockos.com/licecap/).

## Notes

Describe any challenges encountered while building the app.

The limit of requests created an issue when implementing infinite scrolling, and when view appeared.
I also attempted to use attributed text for label, but ultimately ended up using multiple labels instead
Limited time prevented me from getting desired results 

## License

    Copyright [2017] [Steven Hurtado]

    Licensed under the Apache License, Version 2.0 (the "License");
    you may not use this file except in compliance with the License.
    You may obtain a copy of the License at

        http://www.apache.org/licenses/LICENSE-2.0

    Unless required by applicable law or agreed to in writing, software
    distributed under the License is distributed on an "AS IS" BASIS,
    WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
    See the License for the specific language governing permissions and
    limitations under the License.
