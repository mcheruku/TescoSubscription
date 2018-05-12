USE TescoSubscription
GO

/*******************************************************************************************  
********************************************************************************************  
** TYPE           : ROLLBACK SCRIPT  
** NAME           : Procedure [Coupon].[SearchCoupon]   
** AUTHOR         : INFOSYS TECHNOLOGIES LIMITED  
** DESCRIPTION    : THIS SCRIPT WILL ROLLBACK PROCEDURE [Coupon].[SearchCoupon]
** DATE WRITTEN   : 09th July 2013                    
** ARGUMENT(S)    : NONE
** RETURN VALUE(S): NONE
*******************************************************************************************  
********************************************************************************************/
/*
	--Modifications History--
	Changed On		Changed By		Defect Ref		Change Description
	<dd Mmm YYYY>	<Dev Name>		<TFS no.>		<Summary of changes>

*/
IF OBJECT_ID(N'[Coupon].[SearchCoupon]',N'P') IS NOT NULL
	BEGIN

		DROP PROCEDURE [Coupon].[SearchCoupon] 

		IF OBJECT_ID(N'[Coupon].[SearchCoupon]',N'P') IS NULL
			BEGIN
				PRINT 'SUCCESS - Procedure [Coupon].[SearchCoupon]  dropped.'
			END
		ELSE
			BEGIN
				RAISERROR('FAIL - Procedure [Coupon].[SearchCoupon]  not dropped.',16,1)
			END
	END
ELSE
	BEGIN
		PRINT 'NOT EXISTS - Procedure [Coupon].[SearchCoupon]  does not exist.'
	END
GO