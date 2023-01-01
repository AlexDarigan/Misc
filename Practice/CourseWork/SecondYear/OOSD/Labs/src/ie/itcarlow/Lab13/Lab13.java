package ie.itcarlow.Lab13;

import java.awt.Dimension;

import javax.swing.BoxLayout;
import javax.swing.JComboBox;
import javax.swing.JComponent;
import javax.swing.JFrame;
import javax.swing.JLabel;
import javax.swing.JPanel;
import javax.swing.JCheckBox;
import javax.swing.JButton;

public class Lab13 {
	final static Dimension MAX_SIZE = new Dimension(300, 150);
	
	public static void main(String[] args) {
		
		// Creating Frame
		JFrame frame = new JFrame();
		frame.setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
		
		frame.setSize(MAX_SIZE);
		frame.setLayout(new BoxLayout(frame.getContentPane(), BoxLayout.Y_AXIS));
		
		JLabel l1 = new JLabel("Hello");
		JLabel l2 = new JLabel("World");
		JLabel l3 = new JLabel("!!!!!");
		
		String[] items = new String[]{"RED"};
		JComboBox<String> comboBox = new JComboBox<String>(items);
		
		JPanel panel = new JPanel();
		panel.setLayout(new BoxLayout(panel, BoxLayout.X_AXIS));
		JCheckBox cb1 = new JCheckBox("background");
		JCheckBox cb2 = new JCheckBox("foreground");
		
		panel.add(cb1);
		panel.add(cb2);
		panel.setMaximumSize(MAX_SIZE);
		
		JPanel panel2 = new JPanel();
		panel.setLayout(new BoxLayout(panel, BoxLayout.X_AXIS));
		JButton b1 = new JButton("Ok");
		JButton b2 = new JButton("Cancel");
		
		panel2.add(b1);
		panel2.add(b2);
		panel2.setMaximumSize(MAX_SIZE);
		
		
		frame.add(comboBox);
		frame.add(panel);
		frame.add(panel2);
		
		frame.setVisible(true);
	}

}
