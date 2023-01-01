package ie.itcarlow.Lab14;

import java.awt.BorderLayout;
import java.awt.Color;
import java.awt.Dimension;
import java.awt.GridBagConstraints;
import java.awt.GridBagLayout;

import javax.swing.*;

public class Lab14 {

	public static void main(String[] args) {
		
		JFrame frame = new JFrame();
		frame.setTitle("Printer");
		frame.setSize(600, 300);
		frame.setMinimumSize(new Dimension(600, 300));
		frame.setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
		frame.setLayout(new BorderLayout());
		
		
		// Top Label
		JLabel label = new JLabel("Printer: MyPrinter");
		frame.add(label, BorderLayout.NORTH);
		
		// Vertical Menu
		JPanel vMenu = new JPanel();
		vMenu.setLayout(new BoxLayout(vMenu, BoxLayout.Y_AXIS));
		vMenu.add(new JButton("Ok"));
		vMenu.add(new JButton("Cancel"));
		vMenu.add(new JButton("Setup..."));
		vMenu.add(new JButton("Help"));
		frame.add(vMenu, BorderLayout.EAST);

		// Center Menus
		JPanel center = new JPanel();
		GridBagLayout g = new GridBagLayout();
		GridBagConstraints c = new GridBagConstraints();
		center.setLayout(g);
		
		JPanel blank1 = new JPanel();
		blank1.setBackground(Color.WHITE);
		c.gridx = 0;
		c.gridy = 0;
		c.gridheight = 3;
		c.fill = GridBagConstraints.VERTICAL;
		center.add(blank1, c);
		
		JCheckBox image = new JCheckBox("Image");
		c.gridx = 1;
		c.gridy = 0;
		c.gridheight = 1;
		c.fill = GridBagConstraints.HORIZONTAL;
		center.add(image, c);
		
		JCheckBox text = new JCheckBox("Text");
		c.gridx = 1;
		c.gridy = 1;
		c.gridheight = 1;
		c.fill = GridBagConstraints.HORIZONTAL;
		center.add(text, c);
		
		JCheckBox code = new JCheckBox("Code");
		c.gridx = 1;
		c.gridy = 2;
		c.gridheight = 1;
		c.fill = GridBagConstraints.HORIZONTAL;
		center.add(code, c);
		
		JPanel blank2 = new JPanel();
		blank2.setBackground(Color.WHITE);
		c.gridx = 2;
		c.gridy = 0;
		c.gridheight = 3;
		c.fill = GridBagConstraints.VERTICAL;
		center.add(blank2, c);
		
		JRadioButton selection = new JRadioButton("Selection");
		c.gridx = 3;
		c.gridy = 0;
		c.gridheight = 1;
		c.fill = GridBagConstraints.HORIZONTAL;
		center.add(selection, c);
		
		JRadioButton all = new JRadioButton("All");
		c.gridx = 3;
		c.gridy = 1;
		c.gridheight = 1;
		c.fill = GridBagConstraints.HORIZONTAL;
		center.add(all, c);
		
		JRadioButton applet = new JRadioButton("Applet");
		c.gridx = 3;
		c.gridy = 2;
		c.gridheight = 1;
		c.fill = GridBagConstraints.HORIZONTAL;
		center.add(applet, c);
		
		JPanel blank3 = new JPanel();
		blank3.setBackground(Color.WHITE);
		c.gridx = 4;
		c.gridy = 0;
		c.gridheight = 3;
		c.fill = GridBagConstraints.VERTICAL;
		center.add(blank3, c);
		
		frame.add(center, BorderLayout.CENTER);
		
		// Bottom Horizontal Menu
		JPanel hMenu = new JPanel();
		hMenu.setLayout(new BoxLayout(hMenu, BoxLayout.X_AXIS));
		hMenu.add(new JLabel("Print Quality: "));
		hMenu.add(new JComboBox<String>());
		hMenu.add(new JCheckBox(" Print To File"));
		frame.add(hMenu, BorderLayout.SOUTH);
		
		
		frame.pack();
		frame.setVisible(true);
	}
}
