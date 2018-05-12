USE TescoSubscription
GO
/*

	Author:			Robin
	Date created:	14-April-2014
	Purpose:		Rollback Table [Coupon].[CouponRedemption]

	--Modifications History--
	Changed On		Changed By		Defect Ref		Change Description
	<dd Mmm YYYY>	<Dev Name>		<TFS no.>		<Summary of changes>

*/



--------------- Drop column IsPreAuth ------------------------

IF EXISTS(SELECT 1 FROM  information_schema.columns      
				WHERE table_schema      = 'Coupon'
				AND table_name          = 'CouponRedemption'
				AND column_name         = 'Ro_No') 
BEGIN  
    ALTER TABLE [Coupon].[CouponRedemption] DROP CONSTRAINT PK_Coupon_CouponRedemption_Ro_No
         
	ALTER TABLE  [Coupon].[CouponRedemption] DROP COLUMN Ro_No 

END
     PRINT 'Constraint PK_Coupon_CouponRedemption_Ro_No and Column tescosubscription.CustomerPaymentHistory.Ro_No Droppped'

