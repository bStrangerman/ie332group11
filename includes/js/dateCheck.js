// https://www.informationbuilders.com/support/developers/javascript-validate-date-entry

//--------------------------------------------------------------------------
//This function verifies if the start date is prior to end date.
//--------------------------------------------------------------------------
function checkEnteredDates(stdateval,endateval){
 //seperate the year,month and day for the first date
 var stryear1 = stdateval.substring(6);
 var strmth1  = stdateval.substring(0,2);
 var strday1  = stdateval.substring(5,3);
 var date1    = new Date(stryear1 ,strmth1 ,strday1);

 //seperate the year,month and day for the second date
 var stryear2 = endateval.substring(6);
 var strmth2  = endateval.substring(0,2);
 var strday2  = endateval.substring(5,3);
 var date2    = new Date(stryear2 ,strmth2 ,strday2 );

 var datediffval = (date2 - date1 )/864e5;

 if(datediffval <= 0){
  alert("Start date must be prior to end date");
  return false;
 }
 return true;
}
