package com.shop.tables;

import com.shop.repository.Repositories;
import com.shop.repository.Repository;
import com.shop.models.Model;
import com.shop.view.TableView;

import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;

/**
 * The base Table Module Controller
 * @author David Darigan
 * @version 0.1.0
 */
public class Table {

    protected Repository repository;
    protected TableView view;
    protected Repositories repos;

    public Table(Repository model,  String title) {
        this.repository = model;
        view = new TableView(model, title);
        view.addListener(new OnButtonPressed());
    }

    public void setRepos(Repositories repos) {
        this.repos = repos;
    }

    /** @return the TableView */
    public TableView getView() {
        return view;
    }

    /**
     * Updates the view and repository/model
     */
    public void update() {
        repository.update();
        view.update();
    }

    /**
     * A virtual function to be implemented by subclasses
     * @param model The model that shares the same row as the Button that was pressed
     */
    protected void onButtonPressed(Model model) { /* Override where applicable */}

    /**
     * Executes a virtual function when the single (if any button) on the corresponding table view is pressed
     */
    private class OnButtonPressed implements ActionListener
    {
        @Override
        public void actionPerformed(ActionEvent e) {
            if(e.getSource() instanceof TableView.TableButton tButton)
            onButtonPressed(repository.getById(tButton.getId()));
        }
    }
}
