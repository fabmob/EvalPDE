<?php
/**
 * Mail à destination des administrateurs pour leur spécifier qu'un utilisateur a refusé la transmission de ses données personnelles
 */
class Ademe_Mail_RefusTransmissionDonneesPersonnelles extends Ademe_Mail
{
    public function __construct(Ademe_Model_User $user)
    {
        parent::__construct('UTF-8');
        $this->setUser($user);
        $this->setSection('inscription');
    }

    public function prepareContent($request = null)
    {
        $mailConfig = Zend_Registry::get('config')->get('mail');

        $options = $this->getOptions();

        $this->setSubject($mailConfig->get('sujet').' - Refus RGPD - ' . $options['nom'] . $options['prenom']);

        $bodyTxt = sprintf(
            $this->getTemplate(),
            $options['prenom'],
            $options['nom'],
            $this->getToken()->getToken(),
            str_replace("[EOL]", PHP_EOL, $mailConfig->get('signature'))
        );
        $this->setBodyText($bodyTxt);
    }
}