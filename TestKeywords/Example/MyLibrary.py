import robot.api.logger
import robot.utils.asserts
import subprocess

def execute_command(command):
    result = subprocess.check_output(command, shell=True)
    return result.decode().strip()

def Connect():
    """Pretend to connect to the cloud."""
    robot.api.logger.info('Connect to the cloud')

def Disconnect():
    """Pretend to disconnect from the cloud."""
    robot.api.logger.info('Disconnect from the cloud')