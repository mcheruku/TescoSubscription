USE TescoSubscription
GO

/*
 TYPE           : Rollback Script  
 NAME           : Procedure [Coupon].[SearchCoupons]   
 AUTHOR         : Robin  
 DESCRIPTION    : THIS SCRIPT WILL ROLLBACK PROCEDURE [Coupon].[SearchCoupons]
 DATE WRITTEN   : 7/April/2014                   
 
	--Modifications History--
	Changed On		Changed By		Defect Ref		Change Description
	<dd Mmm YYYY>	<Dev Name>		<TFS no.>		<Summary of changes>

*/
IF OBJECT_ID(N'[Coupon].[SearchCoupons]',N'P') IS NOT NULL
	BEGIN

		DROP PROCEDURE [Coupon].[SearchCoupons] 

		IF OBJECT_ID(N'[Coupon].[SearchCoupons]',N'P') IS NULL
			BEGIN
				PRINT 'SUCCESS - Procedure [Coupon].[SearchCoupons]  dropped.'
			END
		ELSE
			BEGIN
				RAISERROR('FAIL - Procedure [Coupon].[SearchCoupons]  not dropped.',16,1)
			END
	END
ELSE
	BEGIN
		PRINT 'NOT EXISTS - Procedure [Coupon].[SearchCoupons]  does not exist.'
	END
GO