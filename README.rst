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

``fluent-bit``
------------

Shortcut for installing the fluentbit package, configuring the service and configuring fluentbit.

``fluent-bit.install``
---------------------

Installs the fluentbit package

``fluent-bit.service``
---------------------

Configures the fluentbit service with upstart/systemd etc

``fluent-bit.config``
--------------------

Configures fluentbit input/output plugins
