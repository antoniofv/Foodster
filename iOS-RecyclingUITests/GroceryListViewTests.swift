//
//  GroceryListViewTests.swift
//  iOS-RecyclingUITests
//
//  Created by Antonio Fernandez Vega on 17/2/23.
//

import XCTest

final class GroceryListViewTests: XCTestCase {
    
    let app = XCUIApplication()

    override func setUpWithError() throws {
        continueAfterFailure = true

        app.launchArguments = AppArguments.buildArguments([.inMemoryDatabase])
        app.launch()
    }
    
    // MARK: - Tests

    func testEmptyGroceryList() throws {
        let emptyListText = app.staticTexts[AccessibilityIdentifiers.GroceryListView.emptyListMessage]
        XCTAssert(emptyListText.exists)
    }
    
    func testAddGroceryListItem() throws {
        // Check if the add button is in the toolbar
        let addButton = app.buttons[AccessibilityIdentifiers.GroceryListView.addButton]
        XCTAssert(addButton.exists)
        XCTAssert(addButton.isEnabled)
        
        // Check that there are now rows in the table
        XCTAssert(app.cells.count == 0)
        
        // Add a new grocery item to the list
        addButton.tap()
        
        let tableRow = app.cells.element
        XCTAssert(tableRow.exists)
        
        let rowTextField = tableRow.textFields.element
        XCTAssert(rowTextField.exists)
        XCTAssert(rowTextField.isHittable)
        
        rowTextField.typeText("Bananas")
        app.keyboards.buttons["Return"].tap()
        
        XCTAssert(app.textFields["Bananas"].exists)
    }
    
    func testMoveGroceryListItem() throws {
        // Check if the add button is in the toolbar
        let addButton = app.buttons[AccessibilityIdentifiers.GroceryListView.addButton]
        XCTAssert(addButton.exists)
        XCTAssert(addButton.isEnabled)
        
        // Check that there are now rows in the table
        XCTAssert(app.cells.count == 0)
        
        // Add some items to the list.
        for (index, itemName) in ["Bananas", "Pears", "Apples"].enumerated() {
            // Add a new grocery item to the list
            addButton.tap()
            
            let tableRow = app.cells.element(boundBy: index)
            let rowTextField = tableRow.textFields.element
            rowTextField.typeText(itemName)
            app.keyboards.buttons["Return"].tap()
            
            XCTAssert(app.textFields[itemName].exists)
        }

        // Drag the last row to the first position.
        app.cells
            .element(boundBy: 2)
            .press(
                forDuration: 0.5,
                thenDragTo: app.cells.element(boundBy: 0),
                withVelocity: .default,
                thenHoldForDuration: 0.5
            )

        // Check that the first row is correct.
        let newFirstRow = app.cells.element(boundBy: 0)
        let newFirstTextField = newFirstRow.textFields.element
        XCTAssertEqual(newFirstTextField.value as! String, "Apples")
    }
    
    func testRemoveGroceryListItem() {
        // Check that there are now rows in the table
        XCTAssert(app.cells.count == 0)

        // Add a new grocery item to the list
        app.buttons[AccessibilityIdentifiers.GroceryListView.addButton].tap()

        let row = app.cells.element
        let textField = row.textFields.element
        textField.typeText("Banana")
        app.keyboards.buttons["Return"].tap()
        
        XCTAssert(app.textFields["Banana"].exists)

        // Delete the item and wait until it fully disappears
        row.swipeLeft()
        app.buttons["Delete"].tap()
        expectation(for: NSPredicate(format: "exists == 0"), evaluatedWith: textField)
        waitForExpectations(timeout: 2)
        
        // Check that the list is empty and the empty list text is displayed.
        XCTAssert(!app.textFields["Banana"].exists)
        XCTAssert(app.cells.count == 0)
        XCTAssert(app.staticTexts[AccessibilityIdentifiers.GroceryListView.emptyListMessage].exists)
    }

}
