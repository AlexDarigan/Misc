package ie.itcarlow.Lab12;

import javax.swing.JFrame;
import javax.swing.UIManager;
import javax.swing.UnsupportedLookAndFeelException;
import javax.swing.JButton;

public class Lab12 {
	
	public static void main(String[] args) throws ClassNotFoundException, InstantiationException, IllegalAccessException, UnsupportedLookAndFeelException {
		UIManager.setLookAndFeel("javax.swing.plaf.metal.MetalLookAndFeel");
		new Lab12();
	}

	public Lab12() throws ClassNotFoundException, InstantiationException, IllegalAccessException, UnsupportedLookAndFeelException {
		// OK Button
		JButton okButton = new JButton("Ok");
		
		JFrame f=new JFrame();
		
		okButton.setSize(100, 50);
		okButton.setVisible(true);
		f.add(okButton);
		
		f.setSize(400, 200);
		f.setLayout(null);
		f.setVisible(true);
		f.setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);    
	}
	
	
}
