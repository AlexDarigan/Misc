package ie.itcarlow.Lab11;

import java.awt.Color;

//Converts a Fahrenheit temperature entered by the user to Celsius, or vice versa

import java.awt.GridLayout;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;
import java.awt.event.WindowAdapter;
import java.awt.event.WindowEvent;
import javax.swing.JFrame;
import javax.swing.JLabel;
import javax.swing.JTextField;

public class ConvertTemp extends JFrame {
	
	private JTextField fahrenField = new JTextField();
	private JTextField celsiusField = new JTextField();
	
	// Constructor
	public ConvertTemp(String title)	{
		// Set title for frame and choose layout
		super(title);
		getContentPane().setLayout(new GridLayout(2, 2));
		

		// Add Fahrenheit label and text field to frame
		add(new JLabel("Fahrenheit"));
		add(fahrenField);
		
		// Attach listener to text field
		FahrenheitListener fahrenListener = new FahrenheitListener();
		fahrenField.addActionListener(fahrenListener);
		
		// Add Celsius label and text field to frame
		add(new JLabel("Celsius"));
		add(celsiusField);
		
		// Attach listener to text field
		CelsiusListener celsiusListener = new CelsiusListener();
		celsiusField.addActionListener(celsiusListener);

		// Attach window listener
		addWindowListener(new WindowCloser());
	}//end constructor

	class FahrenheitListener implements ActionListener {

		@Override
		public void actionPerformed(ActionEvent event) {
			celsiusField.setText(Double.toString((Double.parseDouble(event.getActionCommand()) - 32) * 5/9));
		}
	}
	
	class CelsiusListener implements ActionListener {

		@Override
		public void actionPerformed(ActionEvent event) {
			fahrenField.setText(Double.toString(Double.parseDouble(event.getActionCommand()) * 9/5 + 32));
		}
		
	}

	// Listener for window
	class WindowCloser extends WindowAdapter {
		public void windowClosing(WindowEvent evt) {
			System.exit(0);
		}
	}

}//end class
