<style>
#countdown-wrap {
  width: 100%;
  height: 10px;
  //border: 1px solid black;
  padding: 20px;
  font-family: arial;
  max-width: 650px;
  margin: 15px auto 30px;
}

#goal {
  font-size: 48px;
  text-align: right;
  color: #FFF;
  @media only screen and (max-width : 640px) {
    text-align: center;
  }

}

#glass {
  width: 100%;
  height: 20px;
  background: #c7c7c7;
  border-radius: 10px;
  float: left;
  overflow: hidden;
}

#progress {
  float: left;
  width: <?php echo $percentage;?>%;
  height: 20px;
  background: #FF5D50;
  z-index: 333;
  //border-radius: 5px;
}

.goal-stat {
  width: 25%;
  //height: 30px;
  padding: 10px;
  float: left;
  margin: 0;
  color: #FFF;

  @media only screen and (max-width : 640px) {
    width: 50%;
    text-align: center;
  }
}

.goal-number, .goal-label {
  display: block;
}

.goal-number {
  font-weight: bold;
}
</style>