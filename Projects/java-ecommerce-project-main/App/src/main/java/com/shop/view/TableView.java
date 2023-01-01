package com.shop.view;

import com.shop.repository.Repository;

import javax.swing.*;
import javax.swing.event.TableModelEvent;
import javax.swing.event.TableModelListener;
import javax.swing.table.TableCellRenderer;
import java.awt.BorderLayout;
import java.awt.Component;
import java.awt.event.ActionListener;

public class TableView extends JPanel {

    private JTable jTable = new JTable();
    private JScrollPane jPane = new JScrollPane(jTable);
    private TableButton tButton;

    public TableView(Repository repo, String title) {
        setBorder(BorderFactory.createEtchedBorder());
        setLayout(new BorderLayout());
        add(jPane, BorderLayout.CENTER);
        jTable.setModel(repo);
        this.tButton = new TableButton(title);
        repo.addTableModelListener(new OnTableDataChanged());
    }

    public void addListener(ActionListener listener) {
        tButton.addActionListener(listener);
    }

    public void update() {
        if(tButton.getText() != "") {
            jTable.getColumn("Action").setCellRenderer(new ButtonRenderer());
            jTable.getColumn("Action").setCellEditor(new ButtonEditor());
        }
    }

    private class OnTableDataChanged implements TableModelListener {

        @Override
        public void tableChanged(TableModelEvent e) {
            update();
        }
    }

    private class ButtonRenderer extends JButton implements TableCellRenderer
    {
        @Override
        public Component getTableCellRendererComponent(JTable table, Object value, boolean isSelected, boolean hasFocus, int row, int column) {
            setText(tButton.getText());
            return this;
        }
    }

    private class ButtonEditor extends DefaultCellEditor
    {
        public ButtonEditor() {
            super(new JCheckBox());
        }

        public Component getTableCellEditorComponent(JTable table, Object value, boolean isSelected, int row, int column) {
            tButton.setId(Integer.valueOf(String.valueOf(table.getModel().getValueAt(row, 0))));
            return tButton;
        }
    }

    /**
     * A Button to be rendered and edited that will pass the data of the currently selected row to the parent controllers
     */
    public class TableButton extends JButton
    {
        private int id;
        public TableButton(String title) { super(title); }
        public void setId(int id) { this.id = id; }
        public int getId() { return id; }
    }


}
