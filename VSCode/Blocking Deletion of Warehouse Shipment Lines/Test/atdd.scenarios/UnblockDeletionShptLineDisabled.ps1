Feature 'Unblock Deletion of Whse. Shpt. Line disabled'{
    Scenario 5 'Delete by user with no allowance manually created whse. shpt. line'{
        Given	'Disable "Unblock Deletion of Shpt. Line" on warehouse setup'
        Given	'Location with require shipment'
        Given	'Warehouse employee for current user with no allowance'
        Given	'Manually created warehouse shipment from released sales order with one line with require shipment location'
        When	'Delete warehouse shipment line'
        Then	'Warehouse shipment line is deleted'
    }

    Scenario 6 'Delete by user with no allowance automatically created whse. shpt. line'{
        Given	'Disable "Unblock Deletion of Shpt. Line" on warehouse setup'
        Given	'Location with require shipment'
        Given	'Warehouse employee for current user with no allowance'
        Given	'Automatically created warehouse shipment from released sales order with one line with require shipment location'
        When	'Delete warehouse shipment line'
        Then	'Error disallowing deletion'
    }
    
    Scenario 7 'Delete by user with allowance manually created whse. shpt. line'{
        Given	'Disable "Unblock Deletion of Shpt. Line" on warehouse setup'
        Given	'Location with require shipment'
        Given	'Warehouse employee for current user with no allowance'
        Given	'Manually created warehouse shipment from released sales order with one line with require shipment location'
        When	'Delete warehouse shipment line'
        Then	'Warehouse shipment line is deleted'
    }

    Scenario 8 'Delete by user with allowance automatically created whse. shpt. line with confirmation with confirmation' {
        Given	'Disable "Unblock Deletion of Shpt. Line" on warehouse setup'
        Given	'Location with require shipment'
        Given	'Warehouse employee for current user with allowance'
        Given	'Automatically created warehouse shipment from released sales order with one line with require shipment location'
        When	'Delete warehouse shipment line and select yes in confirm'
        Then	'Warehouse shipment line is deleted'
    }

    Scenario 11 'Delete by user with allowance automatically created whse. shpt. line with no confirmation' {
        Given	'Disable "Unblock Deletion of Shpt. Line" on warehouse setup'
        Given	'Location with require shipment'
        Given	'Warehouse employee for current user with allowance'
        Given	'Automatically created warehouse shipment from released sales order with one line with require shipment location'
        When	'Delete warehouse shipment line and select no in confirm'
        Then	'Empty error occurred'
    }

    Scenario 10 '"Allowed to Delete Shpt. Line" is editable on warehouse employees page' {
        Given	'Warehouse employee for current user'
        When	'Disable "Unblock Deletion of Shpt. Line" on warehouse setup'
        Then	'Allowed to Delete Shpt. Line is editable on warehouse employees page'
    }
}