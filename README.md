## Build Twitter Clone

In this section, you are going to build a Twitter clone. Below are the requirements given in subsections.
Create new repo in your git account, and for each subsection raise PR in repo, get it reviewed from your mentor.

### Requirements:
To build exact clone of twitter app.

**Section 1: Build Rails App** 
- Create new Rails app with latest Rails and Ruby versions.
- Setup postgres database. 

**Section 2: User Auth** 
- Setup User model (name, email, twitter-handle, password, avatar(profile-image))
- Setup basic auth using twitter-handle and password.
- Signup, Signin, Forget-password features.

**Section 3: Tweets**
- Setup Tweet Model (tweet-body, tweet-creator, time)
- User can create, delete tweet. (Tweet is not editable)

**Section 4: Dashboard and Profile**
- Dashboard page to display all tweets by all users. Each tweet should show user-name, tweet body and creation-time of tweet.
- Dashboard should have tweet-form at the start of the page.
- Creating new tweet should display tweet at the top of all tweets.
- Profile page should have two sections: "My Tweets", "Settings"
- "My Tweets" should show only tweets by current-user
- "Settings" page to allow user to update name, email, twitter-handle, password, avatar(profile-image).

**Section 5: Follow and Unfollow**
- User can follow and unfollow other users.
- On dashboard, clicking on user-name should show profile page of other users, which will show other user's twitter handle and his tweets.
- On user profile page, next to user's name show "Follow" or "Unfollow" button. "Follow" button should toggle to "Unfollow" when logged-in user starts following other-user.
- On profile page, also display count of Followers and Following. Clicking on this count should show list of users. (Refer how it shows in twitter)

**Section 6: Like Tweet**
- User can like other user's tweets.
- Below each tweet there should be like icon (same as twitter app). Clicking on like icon, it will highlight it, clicking on it again should remove like.
- Next to like icon, show the number of likes received on that specific tweet.
- Clicking on likes count should show the list of users who have liked tweet.

**Section 7: Reply Tweet**
- User can reply on other tweets (including his own tweets)
- Below each tweet, display reply icon, clicking on reply icon should take user to tweet's show page and from there user should be able to add reply on that tweet.
- Every reply is also considered as a tweet. (Refer on twitter how replies works.)

**Section 8: Retweet**
- User can retweet on other tweets (including his own tweets)
- Below each tweet, display retweet icon, clicking on retweet icon should create a new tweet for the logged-in user with referencing same tweet.
- On dashboard, it should show main tweet and at top of it, should say "<logged-in user_name> retweeted".
- Every retweet is also considered as a tweet. (Refer on twitter how retweet works.)

**Section 9: Notifications**
- Notification will be sent for every like, reply-tweet, and for new follower.
- Show notification-bell icon in top navigation bar. Next to icon also display count of unread notifications.
- Clicking on it will show all notifications received for logged-in user.
- Clicking on notification should take to respective tweet.


![Screenshot 2022-02-22 at 11 43 58 AM](https://user-images.githubusercontent.com/1950768/155078358-4f093178-e4f2-4214-8281-ec7d297390a8.png)
![Untitled-2022-02-22-1115](https://user-images.githubusercontent.com/1950768/155106892-e5a80027-9eca-42f2-b5ed-6e02051ebd3c.png)
