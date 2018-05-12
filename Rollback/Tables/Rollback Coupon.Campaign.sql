/*

	Created By:		Robin
	Date created:	07-Feb-2014
	Purpose:		Rollback table [Coupon].[Campaign] [Script for current release]

	--Modifications History--
	Changed On         Changed By        Defect           Change Description
    
*/




--------------- Rollback Alter column [PlanName] ------------------------

IF EXISTS(SELECT 1 FROM information_schema.columns      
				WHERE TABLE_SCHEMA      = 'Coupon'
				AND TABLE_NAME			= 'Campaign'
				AND COLUMN_NAME         = 'UsageTypeID'
                )
               
BEGIN 
 
ALTER TABLE [Coupon].[Campaign] DROP CONSTRAINT [DF_UsageTypeID]

ALTER TABLE [Coupon].[Campaign]
DROP COLUMN [UsageTypeID] 

PRINT 'Column Coupon.Campaign.UsageTypeID is Droped'
END

ELSE
PRINT 'Column Coupon.Campaign.UsageTypeID does not exists'
GO


GO

--------------- Rollback Alter column [IsMutuallyExclusive] ------------------------

IF EXISTS(SELECT 1 FROM information_schema.columns      
				WHERE TABLE_SCHEMA      = 'Coupon'
				AND TABLE_NAME			= 'Campaign'
				AND COLUMN_NAME         = 'IsMutuallyExclusive'
                )
               
BEGIN 
ALTER TABLE [Coupon].[Campaign] DROP CONSTRAINT [DF_IsMutuallyExclusive] 


ALTER TABLE [Coupon].[Campaign]
DROP COLUMN [IsMutuallyExclusive] 

PRINT 'Column Coupon.Campaign.IsMutuallyExclusive is Droped'
END

ELSE
PRINT 'Column Coupon.Campaign.IsMutuallyExclusive does not exists'
GO

 