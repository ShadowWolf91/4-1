import random
import matplotlib.pyplot as plt
import numpy as np

from deap import base
from deap import creator
from deap import tools
from deap import algorithms

#Определим ряд констант
ONE_MAX_LENGTH = 100    # число генов в хромосоме
POPULATION_SIZE = 200   # количество индивидов в популяции
P_CROSSOVER = 0.9       # вероятность скрещивания
P_MUTATION = 0.1        # вероятность мутации индивида
MAX_GENERATIONS = 50    # максимальное количество поколений

#Создадим класс FitnessMax, который наследуется от базового класса base.Fitness,
#который отвечает за операции над значениями приспособленности конкретного индивида.
creator.create("FitnessMax", base.Fitness, weights=(1.0,))

#Создадим класс Individual, который представляет индивида популяции.
creator.create("Individual", list, fitness=creator.FitnessMax)

#Создадим псевдоним функции random.randint, которая бы генерировала случайные значения 0 или 1 для хромосом
toolbox = base.Toolbox()
toolbox.register("zeroOrOne", random.randint, 0, 1)

#Определим функцию для генерации хромосомы
toolbox.register("individualCreator", tools.initRepeat, creator.Individual, toolbox.zeroOrOne, ONE_MAX_LENGTH)

#Определим функцию генерации популяции
toolbox.register("populationCreator", tools.initRepeat, list, toolbox.individualCreator)

#Создадим популяцию заданного размера
population = toolbox.populationCreator(n=POPULATION_SIZE)

#Определим функции для операций турнирного отбора, одноточечного скрещивания и мутации (инвертирование бита)
toolbox.register("select", tools.selTournament, tournsize=3)
toolbox.register("mate", tools.cxOnePoint)
toolbox.register("mutate", tools.mutFlipBit, indpb=1.0/ONE_MAX_LENGTH)

#Определим функцию, которая возвращает кортеж значений приспособленности отдельного индивида
def oneMaxFitness(individual):
    return sum(individual),

toolbox.register("evaluate", oneMaxFitness)
stats = tools.Statistics(lambda ind: ind.fitness.values)

#Определим функции выбора максимальной и средней прспособленности на каждой итерации
stats.register("max", np.max)
stats.register("avg", np.mean)


population, logbook = algorithms.eaSimple(population, toolbox,
                                        cxpb=P_CROSSOVER,
                                        mutpb=P_MUTATION,
                                        ngen=MAX_GENERATIONS,
                                        stats=stats,
                                        verbose=True)

#Выберем поля max и avg из logbook
maxFitnessValues, meanFitnessValues = logbook.select("max", "avg")

plt.plot(maxFitnessValues, color='red', label='max')
plt.plot(meanFitnessValues, color='green', label='avg')
plt.xlabel('Поколение')
plt.ylabel('Макс/средняя приспособленность')
plt.title('Зависимость максимальной и средней приспособленности от поколения')
plt.legend()
plt.show()