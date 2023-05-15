# Student Management System - Flutter/Dart

# Overview
	Android App
	Flutter Framework
	Dart programming language
	SQLite3 Database integration
	Screens: - Add, View, Delete, Update, CRUDs(combined screen for all the CRUD operations)
	Backend & Frontend connectivity was done completely.


# Screens Details

=> 1. Add Screen
	
	- includes Form which contains:
		-- Drop Down menu for prefix
		-- Name, Email, Phone, City TextFields
		-- Validation to each TextField
		-- Error Handling
		-- Border Styling ( ByDefault, OnClick, OnError )
		-- Field Controllers
	- Buttons:
		-- Save Button:
			{
				-> Collect the input of each TextField
				-> Creates an object of StudentModel Class
				-> Converting this StudentModel Class object into Map
				-> Inserting this Map Record to Database using DatabaseHelper function 'insertRecord'
				-> On Successfull insertion of record, a message displays on SnackBar
			}
		-- Reset Button:
			{ -> Clear/Reset the text of each TextField }



=> 2. View Screen
	
	- a Circular Progress Indicator on Click
	- Every record is getting fatched from DB, as UI, it's in form of Card which are combinely stored as ListView.
	- a Trailing icon to each Card, OnClick, it display a Dialog box which have each and every info of that particular Student ( ID, Name, Email, Phone, City, Icon Image based on gender)



=> 3. Delete Screen
	
	- Prompts for Student ID to delete that particular record.
	- TextField contains:
		-- Validation
		-- Error Handling
		-- Border Styling ( ByDefault, OnClick, OnError )
		-- Field Controllers
	- Buttons:
		-- Delete Button:
			{
				-> Collect the Student ID as int from TextField
				-> Checks for existance of the particular Record from Database using DatabaseHelper function 'checkForStudentId':
					- if exists,
						{
							-> deletes the Record from Database using DatabaseHelper function 'deleteRecord'
							-> On Successfull deletion of record, a message displays on SnackBar with Stack back to Home Page
						}
					- if not,
						{
							-> a message displays on SnackBar
						}
			}
		-- Cancel Button:
			{ Bring us back to Home Page }



=> 4. Update Screen
	
	- Prompts for Student ID to update that particular record.
	- TextField contains:
		-- Validation
		-- Error Handling
		-- Border Styling ( ByDefault, OnClick, OnError )
		-- Field Controllers
	- Buttons:
		-- Update Button:
			{
				-> Collect the Student ID as int from TextField
				-> Checks for existance of the particular Record from Database using DatabaseHelper function 'checkForStudentId':
					- if exists, navigates to next screen with passing the validated Student ID
						{
							-> fatch that particular Record from Database using DatabaseHelper function 'getStudentRecordForUpd'
							-> fit them on same TextFields which I introduced in Add Screen
							-> on final update button, 
								- Collect the input of each TextField
								- Creates an object of StudentModel Class
								- Converting this StudentModel Class object into Map
								- Inserting this Map Record to Database using DatabaseHelper function 'updateRecord'
							-> On Successfull updation of record, a message displays on SnackBar with Stack back to Home Page
						}
					- if not,
						{
							-> a message displays on SnackBar
						}
			}
		-- Cancel Button:
			{ -> Bring us back to Home Page }



=> 5. CRUDs Screen
	
	An optimistic combination of all feature which i described above. This screen include View/Delete/Update/Add at one place

	- On click, you will get View feature same as form of Card.
	- Every Card have two trailing icons Update, Delete of that particular record
	- Refreshes at every operation. Refresh on Pulling Down side also included. 
  
