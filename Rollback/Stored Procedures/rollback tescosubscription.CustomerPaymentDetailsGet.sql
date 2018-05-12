/*
	Author:		Saritha K
	Created:	08 Aug 2011
	Purpose:	This script to drop the procedure [tescosubscription].[CustomerPaymentDetailsGet]

	--Modifications History--
 
	Changed On		Changed By		Defect	Change Description 
	

*/ 
	

IF OBJECT_ID(N'[tescosubscription].[CustomerPaymentDetailsGet]',N'P') IS NOT NULL
	BEGIN
		DROP PROCEDURE[tescosubscription].[CustomerPaymentDetailsGet]

		IF OBJECT_ID(N'[tescosubscription].[CustomerPaymentDetailsGet]',N'P') IS NULL
			BEGIN
				PRINT 'SUCCESS: Stored Procedure: [tescosubscription].[CustomerPaymentDetailsGet] - dropped'
			END
		ELSE
			BEGIN
				RAISERROR('FAIL: Stored Procedure: [tescosubscription].[CustomerPaymentDetailsGet] - was not dropped',16,1)	
			END
	END
ELSE
	BEGIN
		PRINT 'NOT EXISTS : Stored Procedure: [tescosubscription].[CustomerPaymentDetailsGet] - Not exists'
	END 
GO



