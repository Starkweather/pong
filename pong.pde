
float ball_x;
float ball_y;
float ball_dir = 1; // Direction in x 
float ball_size = 7;  // Radius of ball
float dy = 2;  // Change in y

// Global variables for the paddle
var paddle_width = 5;
var paddle_height = 40;

var dist_wall = 8;

float total = 0;
float highscore = 0;
float score = 0;

void setup() {
    size(600, 400);
    rectMode(CENTER_RADIUS);
    ellipseMode(CENTER_RADIUS);
    noStroke();
    smooth();
    ball_y = height/2;
    ball_x = 1;
};

void draw() {
    // Background color... RGB
    0%   {background-color: red; left:0px; top:0px;}
    25%  {background-color: yellow; left:200px; top:0px;}
    50%  {background-color: blue; left:200px; top:200px;}
    75%  {background-color: green; left:0px; top:200px;}
    100% {background-color: red; left:0px; top:0px;}
}

/* The element to apply the animation to */
div {
    width: 100px;
    height: 100px;
    position: relative;
    background-color: red;
    animation-name: example;
    animation-duration: 4s;
};

    // Increment x and y by speed of ball
    ball_x += ball_dir * 6.0;
    ball_y += dy;

    // If the ball was missed... start over
    if(ball_x > width+ball_size) {
        ball_x = -width/2 - ball_size;
        ball_y = random((0.25*height), (0.75*height));
        dy = random(-5, 5);
        score = 0;
        document.getElementById("score").innerHTML = "Score = " + score;
    }

    // Constrain paddle to screen
    float paddle_y = constrain(mouseY, paddle_height, height-paddle_height);

    // Test to see if the ball is touching the paddle
    float paddle_x_edge = width-dist_wall-paddle_width-ball_size;

    if((ball_x > paddle_x_edge) && (ball_y > paddle_y - paddle_height - ball_size) && 
       (ball_y < paddle_y + paddle_height + ball_size) && (ball_dir>0)) {
        // If we hit the paddle... change direction
        ball_dir *= -1;
        // Send a message to the main page updating the score...
        score += 1;
        document.getElementById("score").innerHTML = "Score = " + score;
        total += 1;
        document.getElementById("total").innerHTML = "Total Hits = " + total;
        if (score>highscore) {
          highscore = score;
          document.getElementById("highscore").innerHTML = "High Score = " + highscore;
        }
        // Check to see if the mouse is moving... if so calculate how fast
        if(mouseY != pmouseY) {
            dy = (mouseY-pmouseY)/2.0;
            // Clamp how fast it can move the paddle to 5
            if(dy >  5) { dy =  5; }
            if(dy < -5) { dy = -5; }
        }
    } 

    // If ball hits back wall, reverse direction
    if(ball_x < ball_size && ball_dir == -1) {
        ball_dir *= -1;
    }
    // If the ball is touching top or bottom edge, reverse direction
    if(ball_y >= height-ball_size) {
        dy = dy * -1;
    }
    if(ball_y <= ball_size) {
        dy = dy * -1;
    }

    // Draw ball
    fill(0,0,255);
    ellipse(ball_x, ball_y, ball_size, ball_size);

    // Draw the paddle
    fill(255,255,255);
    rect(width-dist_wall, paddle_y, paddle_width, paddle_height);  
};
