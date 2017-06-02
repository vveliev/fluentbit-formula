================
fluentbit-formula
================

A saltstack formula that for installing and configuring fluentbit.

.. note::

    See the full `Salt Formulas installation and usage instructions
    <http://docs.saltstack.com/en/latest/topics/development/conventions/formulas.html>`_.

Available states
================

.. contents::
    :local:

``fluentbit``
------------

Shortcut for installing the fluentbit package, configuring the service and configuring fluentbit.

``fluentbit.install``
---------------------

Installs the fluentbit package

``fluentbit.service``
---------------------

Configures the fluentbit service with upstart/systemd etc

``fluentbit.config``
--------------------

Configures fluentbit input/output plugins
