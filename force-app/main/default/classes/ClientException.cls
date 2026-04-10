/**
 * Business error thrown by service implementations on customer orgs.
 * The package maps this to HTTP 422 Unprocessable Entity.
 *
 * Example:
 *   throw new livymobile.ClientException('Tenant not verified');
 */
global class ClientException extends Exception {}
