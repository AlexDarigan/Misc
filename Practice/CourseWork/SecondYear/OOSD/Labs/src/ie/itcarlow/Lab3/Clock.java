package ie.itcarlow.Lab3;
import java.util.Calendar;

public class Clock 
{
	public static void main(String[] args)
	{
		
		Calendar cal = Calendar.getInstance();
		Time time = new Time(cal.get(Calendar.HOUR_OF_DAY), cal.get(Calendar.MINUTE));
		
		// Terminate loop when the minute changes, we must use == because > won't work when changing from..
		// ..minute 59 to minute 0 on a clock cycle.
		int startingMinute = time.getMinute();
		long previousSecond = System.currentTimeMillis() / 1000;
		while(startingMinute == time.getMinute())
		{
			if(previousSecond < System.currentTimeMillis() / 1000)
			{
				previousSecond = System.currentTimeMillis() / 1000;
				time.tick();
				System.out.println(time);
			}
		}		
	}
}
