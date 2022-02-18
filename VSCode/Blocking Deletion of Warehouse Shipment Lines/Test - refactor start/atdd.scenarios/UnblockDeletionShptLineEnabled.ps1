Feature 'Unblock Deletion of Whse. Shpt. Line enabled'{
    Scenario 1 'Delete by user with no allowance manually created whse. shpt. line'{
        Given	'Enable "Unblock Deletion of Shpt. Line" on warehouse setup'
        Given	'Location with require shipment'
        Given	'Warehouse employee for current user with no allowance'
        Given	'Manually created warehouse shipment from released sales order with one line with require shipment location'
        When	'Delete warehouse shipment line'
        Then	'Warehouse shipment line is deleted'
    }

    Scenario 2 'Delete by user with no allowance automatically created whse. shpt. line'{
        Given	'Enable "Unblock Deletion of Shpt. Line" on warehouse setup'
        Given	'Location with require shipment'
        Given	'Warehouse employee for current user with no allowance'
        Given	'Automatically created warehouse shipment from released sales order with one line with require shipment location'
        When	'Delete warehouse shipment line'
        Then	'Warehouse shipment line is deleted'
    }
    
    Scenario 3 'Delete by user with allowance manually created whse. shpt. line'{
        Given	'Enable "Unblock Deletion of Shpt. Line" on warehouse setup'
        Given	'Location with require shipment'
        Given	'Warehouse employee for current user with no allowance'
        Given	'Manually created warehouse shipment from released sales order with one line with require shipment location'
        When	'Delete warehouse shipment line'
        Then	'Warehouse shipment line is deleted'
    }

    Scenario 4 'Delete by user with allowance automatically created whse. shpt. line' {
        Given	'Enable "Unblock Deletion of Shpt. Line" on warehouse setup'
        Given	'Location with require shipment'
        Given	'Warehouse employee for current user with allowance'
        Given	'Automatically created warehouse shipment from released sales order with one line with require shipment location'
        When	'Delete warehouse shipment line'
        Then	'Warehouse shipment line is deleted'
    }

    Scenario 9 '"Allowed to Delete Shpt. Line" is not editable on warehouse employees page' {
        Given	'Warehouse employee for current user'
        When	'Enable "Unblock Deletion of Shpt. Line" on warehouse setup'
        Then	'Allowed to Delete Shpt. Line is not editable on warehouse employees page'

    }
}