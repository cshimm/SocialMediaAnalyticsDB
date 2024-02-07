CREATE DEFINER=`root`@`localhost` PROCEDURE `process_SMUID`(IN p_SMUID VARCHAR(255))
BEGIN
	DECLARE SM_social_account_id INT;
    SELECT social_account_id INTO SM_social_account_id
    FROM social_account
    WHERE SMUID = p_SMUID;
    IF SM_social_account_id IS NULL THEN
		INSERT INTO social_account (SMUID) values (p_SMUID);
		SET SM_social_account_id = last_insert_id();
    END IF;
END