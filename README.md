# Oasis

Oasis is a tool that scans OpenAPI specifications searching for REST antipatterns.

Oasis uses two techniques to find violations of good practices. One is to statically
analyze the specification. Some antipatterns, however, require a dynamic strategic
in order to be detected. In these cases, Oasis automatically interacts with
the implementation of the API based on the information provided in the OpenAPI specification.

Oasis is a work in progress and currently it is in a very early stage.

## About the name

An oasis is a fundamental place for any traveller marching through the unknown vastness of
a desert. It is a place to rest and to restore your body. Likewise, Oasis aims to allow
one to restore its API to a healthier state.

**Oas**is also starts with `oas`, which is the acronym for OpenAPI specification.
