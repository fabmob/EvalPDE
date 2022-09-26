ALTER TABLE `user`
	ADD COLUMN `consentement` TINYINT(1) NOT NULL AFTER `preferences`,
	ADD COLUMN `date_rgpd` DATETIME NOT NULL AFTER `consentement`;


INSERT INTO texte (`type_texte_id`, `nom`, `texte`) VALUES ('1', 'TEXT_CU201-00', '');
INSERT INTO texte (`type_texte_id`, `nom`, `texte`) VALUES ('2', 'HELP_CU201-00', '');
INSERT INTO texte (`type_texte_id`, `nom`, `texte`) VALUES ('1', 'TEXT_CU310-06', '');
INSERT INTO texte (`type_texte_id`, `nom`, `texte`) VALUES ('2', 'HELP_CU310-06', '');