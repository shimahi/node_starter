module.exports = {
  clearMocks: true,
  coverageProvider: 'babel',
  preset: 'ts-jest',
  testEnvironment: 'node',
  moduleDirectories: ['src', 'node_modules'],
  moduleNameMapper: {
    'src/(.*)$': '<rootDir>/src/$1',
  },
}
