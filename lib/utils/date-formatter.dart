 String formattedDate(DateTime date)
=> date.day.toString() + "\t-\t" + ["January", "February", "March", "April", "May", "June", "July", "August", "September", "October", "November", "December"][date.month-1] + "\t-\t" + date.year.toString();
