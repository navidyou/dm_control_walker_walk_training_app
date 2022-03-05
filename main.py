from dm_control import suite
from dm_control import viewer
import numpy as np

#from absl import app
from flask import Flask

env = suite.load(domain_name="humanoid", task_name="stand")
action_spec = env.action_spec()

# Define a uniform random policy.
def random_policy(time_step):
  del time_step  # Unused.
  return np.random.uniform(low=action_spec.minimum,
                           high=action_spec.maximum,
                           size=action_spec.shape)

app = Flask(__name__)


@app.route('/')
def main():
  viewer.launch(env, policy=random_policy)
  #return 'The living robo is getting prepared!'


#env = suite.load(domain_name="humanoid", task_name="stand")
#action_spec = env.action_spec()





#def main(_):
  # Launch the viewer application.
#  viewer.launch(env, policy=random_policy)

#if __name__ == '__main__':
    # This is used when running locally only. When deploying to Google App
    # Engine, a webserver process such as Gunicorn will serve the app. You
    # can configure startup instructions by adding `entrypoint` to app.yaml.
#    app.run(host='127.0.0.1', port=8080, debug=True)

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=8080, debug=True)


#if __name__ == '__main__':
#  app.run(main)
