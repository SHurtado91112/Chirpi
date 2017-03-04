# Project 4 - *Chirpi*
## *A Twitter Clone*
![chirpilogo_small](https://cloud.githubusercontent.com/assets/11231583/23326859/27f3f01c-fad1-11e6-81fa-5b762c685b5e.png)

**Chirpi** is a basic twitter app to read and compose tweets the [Twitter API](https://apps.twitter.com/).

Time spent: **14** hours spent in total

## User Stories

The following **required** functionality is completed:

- [X] User can sign in using OAuth login flow
- [X] User can view last 20 tweets from their home timeline
- [X] The current signed in user will be persisted across restarts
- [X] In the home timeline, user can view tweet with the user profile picture, username, tweet text, and timestamp.
- [X] Retweeting and favoriting should increment the retweet and favorite count.

The following **optional** features are implemented:

- [X] User can load more tweets once they reach the bottom of the feed using infinite loading similar to the actual Twitter client.
- [X] User should be able to unretweet and unfavorite and should decrement the retweet and favorite count.
- [X] User can pull to refresh.

The following **additional** features are implemented:

- [X] Spring animated splash screen and login screen.
- [X] Elapsed time for each tweet is formatted.
- [X] Retweet/Favorite counts are formatted.
- [X] Border color of each user's avatar is their selected Twitter profile color
- [X] Shows if tweet online was retweeted and by whom it was created
- [X] Formats text appropriately
- [X] Animate retweet and favorite button
- [X] Parses media_url text from tweet and replaces with media image associated with that url

Please list two areas of the assignment you'd like to **discuss further with your peers** during the next class (examples include better ways to implement something, how to extend your app in certain ways, etc):

1. Handling other forms of media; i.e. video, webpages, replies
2. Direct messaging

## Video Walkthrough 

Here's a walkthrough of implemented user stories:

![chirpigif1](https://cloud.githubusercontent.com/assets/11231583/23343278/951576aa-fc36-11e6-8bda-dc01f9b26c40.gif)

GIF created with [LiceCap](http://www.cockos.com/licecap/).

## Notes

Describe any challenges encountered while building the app.

The limit of requests created an issue when implementing infinite scrolling.
I also attempted to use attributed text for label, but ultimately ended up using multiple labels instead

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
